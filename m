From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ALSA: usb: initial USB Audio Device
 Class 3.0 support
Date: Mon, 13 Nov 2017 10:07:08 -0600
Message-ID: <7ac1341d-c2c4-e76a-ac3e-09f5e143044d@linux.intel.com>
References: <1510020080-15849-1-git-send-email-ruslan.bilovol@gmail.com>
 <1510020080-15849-2-git-send-email-ruslan.bilovol@gmail.com>
 <a7815f69-d300-ea47-2a64-b69261a2c5e1@linux.intel.com>
 <CAB=otbRrJ5oCs-ggfMh4i_UZAbCrMwV5aAeVZgFOnNLric_=NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB=otbRrJ5oCs-ggfMh4i_UZAbCrMwV5aAeVZgFOnNLric_=NQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/10/17 8:48 PM, Ruslan Bilovol wrote:
> On Wed, Nov 8, 2017 at 9:38 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> Nice work, thanks! I double-checked all the descriptors and values and
>> didn't find anything problematic, the main comment I have is that the clock
>> source/selection could probably be refactored since the differences are
>> really minor with UAC2, and there is work to do to select the right Audio
>> Interface Association.
>>
>> On 11/6/17 8:01 PM, Ruslan Bilovol wrote:
>>>
>>> Recently released USB Audio Class 3.0 specification
>>> introduces many significant changes comparing to
>>> previous versions, like
>>>    - new Power Domains, support for LPM/L1
>>>    - new Cluster descriptor
>>>    - changed layout of all class-specific descriptors
>>>    - new High Capability descriptors
>>>    - New class-specific String descriptors
>>>    - new and removed units
>>>    - additional sources for interrupts
>>>    - removed Type II Audio Data Formats
>>>    - ... and many other things (check spec)
>>>
>>> It also provides backward compatibility through
>>> multiple configurations, as well as requires
>>> mandatory support for BADD (Basic Audio Device
>>> Definition) on each ADC3.0 compliant device
>>>
>>> This patch adds initial support of UAC3 specification
>>> that is enough for Generic I/O Profile (BAOF, BAIF)
>>> device support from BADD document.
>>
>>
>> Do you mean to say that the selection of the BADD profile or full-blown
>> descriptor capabilities will be handled in a follow-up patch?
> 
> I have no follow-up patch for configuration switching.
> I mean only that it is enough to support BAOF, BAIF profiles.
> however, BAIOF profile won't work correctly, becaus it contains mixer unit
> which is not supported yet in this patch.
> 
> This is because of way I use UAC3. As UAC3 device, I use an UAC3
> gadget implementation which I sent before to linux-usb mailing list:
> http://www.spinics.net/lists/linux-usb/msg162482.html
> 
> The UAC3 gadget implements BAOF+BAIF profile; but not BAIOF profile
> which doesn't make sense in this case (there is no reason to mix Audio IN
> with Audio Out)

sidetone is the main reason for mixing input on output, very useful too 
avoid speaking too loudly into the mic or when you use well-insulated 
headsets. most USB headsets provide this capability.

> 
> Thus I can't implement and test UAC3 mixer handling in current patch,
> so BAIOF profile isn't supported by it yet.
> 
>>
>> It's my understanding from Section 3.3 that a UAC3 device is required to
>> expose
>> - a backwards-compatible configuration (UAC1 or UAC2),
>> - a UAC3 BADD profile
>> - one or more AIA compliant with UAC3 (which may have additional features
>> not present in the baseline description).
> 
> My understanding of Section 3.3 is slightly different. An UAC3 device is
> required to expose:
>   - a backward-compatible first configuration (UAC1 or UAC2)
>   - an UAC3 BADD profile on another configuration, with only one AIA inside
>   - and _may_ have one or more configurations with UAC3 support that
>     provide functionality beyond what is available in BADD

yes, i should have written 0 or more AIA compliant with UAC3

> 
>>
>> And I am not sure how a driver would make the selection...
> 
> In order to test this patch, I created UAC2+UAC3 gadget and manually
> switched to UAC3 configuration on Host by:
> $ echo 2 > /sys/bus/usb/devices/1-1/bConfigurationValue
> 
> I don't think ALSA driver can make decision which configuration to select,
> maybe some userspace tool can handle it, like usb_modeswitch does
> for networking devices.

The BADD profiles were intended to provide a basic descriptors for hosts 
that couldn't handle descriptor parsing. That was a very controversial 
work item, since both the Linux and Windows stacks can parse descriptors 
the usefulness of BADD profiles remains questionable.

I think at some point we should have the following policy
if one UAC3 is available, use the first one
else
     if there is a BADD profile use it
     else
         fall back to UAC1/2

I don't see how a user will ever choose between multiple UAC3 
configurations, should they ever exist, except maybe by trial and error.

> 
>>
>> In theory though, a UAC3 device should work out of the box even if the host
>> only supports UAC1 or UAC2.
> 
> Yes, this is correct, I verified it as well.
> 
>>
>>
>>> +/*
>>> + * v1.0, v2.0 and v3.0 of this standard have many things in common. For
>>> the rest
>>> + * of the definitions, please refer to audio.h and audio-v2.h
>>> + */
>>> +
>>> +/* All High Capability descriptors have these 2 fields at the beginning
>>> */
>>> +struct uac3_hc_descriptor_header {
>>> +       __le16 wLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __le16 wDescriptorID;
>>> +} __attribute__ ((packed));
>>> +
>>> +/* 4.3.1 CLUSTER DESCRIPTOR HEADER */
>>> +struct uac3_cluster_header_descriptor {
>>> +       __le16 wLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __le16 wDescriptorID;
>>> +       __u8 bNrChannels;
>>> +} __attribute__ ((packed));
>>> +
>>> +/* 4.3.2.1 SEGMENTS */
>>> +struct uac3_cluster_segment_descriptor {
>>> +       __le16 wLength;
>>> +       __u8 bSegmentType;
>>> +       /* __u8[0]; segment-specific data */
>>> +} __attribute__ ((packed));
>>> +
>>> +/* 4.3.2.1.1 END SEGMENT */
>>> +struct uac3_cluster_end_segment_descriptor {
>>> +       __le16 wLength;
>>> +       __u8 bSegmentType;              /* Constant END_SEGMENT */
>>> +} __attribute__ ((packed));
>>> +
>>
>>
>> you didn't include the definitions in 4.3.2.1.2
>> Cluster Descriptor Segment
>> Vendor Defined Segment
> 
> Correct, they are not used in BADD so I didn't care much, but I can
> add it in next patchset

ok

> 
>>
>>> +/* 4.3.2.1.3.1 INFORMATION SEGMENT */
>>> +struct uac3_cluster_information_segment_descriptor {
>>> +       __le16 wLength;
>>> +       __u8 bSegmentType;
>>
>>
>> this field is a CHANNEL_INFORMATION constant.
>>
>>> +       __u8 bChPurpose;
>>> +       __u8 bChRelationship;
>>> +       __u8 bChGroupID;
>>> +} __attribute__ ((packed));
>>> +
>>> +/* 4.5.2 CLASS-SPECIFIC AC INTERFACE DESCRIPTOR */
>>> +struct uac3_ac_header_descriptor {
>>> +       __u8 bLength;                   /* 10 */
>>> +       __u8 bDescriptorType;           /* CS_INTERFACE descriptor type */
>>> +       __u8 bDescriptorSubtype;        /* HEADER descriptor subtype */
>>> +       __u8 bCategory;
>>> +
>>> +       /* includes Clock Source, Unit, Terminal, and Power Domain desc.
>>> */
>>> +       __le16 wTotalLength;
>>> +
>>> +       __le32 bmControls;
>>> +} __attribute__ ((packed));
>>> +
>>
>>
>> Missing extended terminal descriptor header from 4.5.2.3.2?
>>
>> Missing multi-function processing unit descriptor header from 4.5.2.10.3 ?
> 
> Yes, I can add them as well.

ok

> 
>>
>>> +
>>> +/* bmAttribute fields */
>>> +#define UAC3_CLOCK_SOURCE_TYPE_EXT     0x0
>>> +#define UAC3_CLOCK_SOURCE_TYPE_INT     0x1
>>> +#define UAC3_CLOCK_SOURCE_ASYNC                (0 << 2)
>>> +#define UAC3_CLOCK_SOURCE_SYNCED_TO_SOF        (1 << 1)
>>> +
>>> +/* 4.5.2.13 CLOCK SELECTOR DESCRIPTOR */
>>> +struct uac3_clock_selector_descriptor {
>>> +       __u8 bLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __u8 bClockID;
>>> +       __u8 bNrInPins;
>>> +       __u8 baCSourceID[];
>>> +       /* bmControls and wCSelectorDescrStr omitted */
>>
>>
>> why is this omitted here and not below in the clock multiplier descriptor?
> 
> That's because in this descriptor ther is variable (unknown) field baCSourceID,
> so we can't define anythyng else after it as per C standard.
> In the clock multiplier descriptor below we don't have such issue.

ah, then maybe explain it, I wasn't sure if there was a technical reason 
or a filter you applied for some other reason.

> 
>>
>>> +} __attribute__((packed) > +
>>> +/* 4.5.2.14 CLOCK MULTIPLIER DESCRIPTOR */
>>> +struct uac3_clock_multiplier_descriptor {
>>> +       __u8 bLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __u8 bClockID;
>>> +       __u8 bCSourceID;
>>> +       __le32 bmControls;
>>> +       __le16 wCMultiplierDescrStr;
>>> +} __attribute__((packed));
>>
>>
>> [snip]
>>
>>> +
>>> +/* 4.5.2.15 POWER DOMAIN DESCRIPTOR */
>>> +struct uac3_power_domain_descriptor {
>>> +       __u8 bLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __u8 bPowerDomainID;
>>> +       __le16 waRecoveryTime1;
>>> +       __le16 waRecoveryTime2;
>>> +       __u8 bNrEntities;
>>> +       __u8 baEntityID[];
>>> +       /* wPDomainDescrStr omitted */
>>
>> why?
>>>
>>> +} __attribute__((packed));
>>> +
>>> +/* As above, but more useful for defining your own descriptors */
>>> +#define DECLARE_UAC3_POWER_DOMAIN_DESCRIPTOR(n)                        \
>>> +struct uac3_power_domain_descriptor_##n {                      \
>>> +       __u8 bLength;                                           \
>>> +       __u8 bDescriptorType;                                   \
>>> +       __u8 bDescriptorSubtype;                                \
>>> +       __u8 bPowerDomainID;                                    \
>>> +       __le16 waRecoveryTime1;                                 \
>>> +       __le16 waRecoveryTime2;                                 \
>>> +       __u8 bNrEntities;                                       \
>>> +       __u8 baEntityID[n];                                     \
>>> +       __le16 wPDomainDescrStr;                                        \
>>> +} __attribute__ ((packed))
>>> +
>>
>>
>> any specific reason why the descriptors are not added in linear order,
>> following the spec definition? all the descriptors below could be added
>> earlier.
> 
> That's because of way I wrote this header. These descritors are added
> in same order as in UAC2 header, then it was more easy to compare
> both headers in order to understand if we can reuse anything from UAC2.
> 
> If course I should reorganize it, but forgot to do :D

I don't know why this was modified, we should have kept the initial 
order in the spec when possible.

> 
>>
>>> +/* 4.5.2.1 INPUT TERMINAL DESCRIPTOR */
>>> +struct uac3_input_terminal_descriptor {
>>> +       __u8 bLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __u8 bTerminalID;
>>> +       __le16 wTerminalType;
>>> +       __u8 bAssocTerminal;
>>> +       __u8 bCSourceID;
>>> +       __le32 bmControls;
>>> +       __le16 wClusterDescrID;
>>> +       __le16 wExTerminalDescrID;
>>> +       __le16 wConnectorsDescrID;
>>> +       __le16 wTerminalDescrStr;
>>> +} __attribute__((packed));
>>> +
>>
>>
>>> +
>>> +/* 4.7.2 CLASS-SPECIFIC AS INTERFACE DESCRIPTOR */
>>> +struct uac3_as_header_descriptor {
>>> +       __u8 bLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __u8 bTerminalLink;
>>> +       __le32 bmControls;
>>> +       __le16 wClusterDescrID;
>>> +       __le64 bmFormats;
>>> +       __u8 bSubslotSize;
>>> +       __u8 bBitResolution;
>>> +       __le16 bmAuxProtocols;
>>> +       __u8 bControlSize;
>>> +} __attribute__((packed));
>>> +
>>> +#define UAC3_FORMAT_TYPE_I_RAW_DATA    (1 << 6)
>>
>> This seems to come from Table A1 in the formats document, is it inserted
>> here because of the relationship with the bmFormats? If yes, we should
>> probably add the full list from Table A1 (as done below for the other codes)
> 
> Yes, this comes from Frmts3.0. However, for bits 0..5 we reuse same
> values from UAC1 spec, thay are same for UAC2 as well.
> See UAC_FORMAT_TYPE_xxx

yes

> 
>>
>>> +
>>> +/* 4.8.1.2 CLASS-SPECIFIC AS ISOCHRONOUS AUDIO DATA ENDPOINT DESCRIPTOR
>>> */
>>> +struct uac3_iso_endpoint_descriptor {
>>> +       __u8 bLength;
>>> +       __u8 bDescriptorType;
>>> +       __u8 bDescriptorSubtype;
>>> +       __le32 bmControls;
>>> +       __u8 bLockDelayUnits;
>>> +       __le16 wLockDelay;
>>> +} __attribute__((packed));
>>> +
>>> +#define UAC3_CONTROL_PITCH             (3 << 0)
>>> +#define UAC3_CONTROL_DATA_OVERRUN      (3 << 2)
>>> +#define UAC3_CONTROL_DATA_UNDERRUN     (3 << 4)
>>
>>
>> these are really masks, no?
> 
> Yes, same as in UAC2, we can drop them as they are not used yet.

ok

> 
>>
>>> +
>>> +/* 6.1 INTERRUPT DATA MESSAGE */
>>> +#define UAC3_INTERRUPT_DATA_MSG_VENDOR (1 << 0)
>>> +#define UAC3_INTERRUPT_DATA_MSG_EP     (1 << 1)
>>
>>
>> this is the same as in UAC2
>>
>>> +
>>> +struct uac3_interrupt_data_msg {
>>> +       __u8 bInfo;
>>> +       __u8 bSourceType;
>>> +       __le16 wValue;
>>> +       __le16 wIndex;
>>> +} __attribute__((packed));
>>
>>
>> This seems identical to UAC2, the difference being the bSourceType with
>> additional values (was bAttribute).
> 
> Yes, this is correct. I made separate structure just to make code reading
> easier. Same is for UAC3_INTERRUPT_DATA_xxx above.

ok. maybe just mention that this is for readability

> 
>>
>>> +
>>> +/* A.2 AUDIO AUDIO FUNCTION SUBCLASS CODES */
>>> +#define UAC3_FUNCTION_SUBCLASS_UNDEFINED       0x00
>>> +#define UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0    0x01
>>> +#define UAC3_FUNCTION_SUBCLASS_GENERIC_IO      0x20
>>> +#define UAC3_FUNCTION_SUBCLASS_HEADPHONE       0x21
>>> +#define UAC3_FUNCTION_SUBCLASS_SPEAKER         0x22
>>> +#define UAC3_FUNCTION_SUBCLASS_MICROPHONE      0x23
>>> +#define UAC3_FUNCTION_SUBCLASS_HEADSET         0x24
>>> +#define UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER 0x25
>>> +#define UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE    0x26
>>
>>
>> mention that these are linked to BADD profiles.
> 
> OK, will do it
> 
>>
>>> +
>>> +/* A.7 AUDIO FUNCTION CATEGORY CODES */
>>> +#define UAC3_FUNCTION_SUBCLASS_UNDEFINED       0x00
>>> +#define UAC3_FUNCTION_DESKTOP_SPEAKER          0x01
>>> +#define UAC3_FUNCTION_HOME_THEATER             0x02
>>> +#define UAC3_FUNCTION_MICROPHONE               0x03
>>> +#define UAC3_FUNCTION_HEADSET                  0x04
>>> +#define UAC3_FUNCTION_TELEPHONE                        0x05
>>> +#define UAC3_FUNCTION_CONVERTER                        0x06
>>> +#define UAC3_FUNCTION_SOUND_RECORDER           0x07
>>> +#define UAC3_FUNCTION_IO_BOX                   0x08
>>> +#define UAC3_FUNCTION_MUSICAL_INSTRUMENT       0x09
>>> +#define UAC3_FUNCTION_PRO_AUDIO                        0x0a
>>> +#define UAC3_FUNCTION_AUDIO_VIDEO              0x0b
>>> +#define UAC3_FUNCTION_CONTROL_PANEL            0x0c
>>> +#define UAC3_FUNCTION_HEADPHONE                        0x0d
>>> +#define UAC3_FUNCTION_GENERIC_SPEAKER          0x0e
>>> +#define UAC3_FUNCTION_HEADSET_ADAPTER          0x0f
>>> +#define UAC3_FUNCTION_SPEAKERPHONE             0x10
>>> +#define UAC3_FUNCTION_OTHER                    0xff
>>> +
>>> +/* A.8 AUDIO CLASS-SPECIFIC DESCRIPTOR TYPES */
>>> +#define UAC3_CS_UNDEFINED              0x20
>>> +#define UAC3_CS_DEVICE                 0x21
>>> +#define UAC3_CS_CONFIGURATION          0x22
>>> +#define UAC3_CS_STRING                 0x23
>>> +#define UAC3_CS_INTERFACE              0x24
>>> +#define UAC3_CS_ENDPOINT               0x25
>>> +#define UAC3_CS_CLUSTER                        0x26
>>> +
>>> +/* A.10 CLUSTER DESCRIPTOR SEGMENT TYPES */
>>> +#define UAC3_SEGMENT_UNDEFINED         0x00
>>> +#define UAC3_CLUSTER_DESCRIPTION       0x01
>>> +#define UAC3_CLUSTER_VENDOR_DEFINED    0x1F
>>> +#define UAC3_CHANNEL_INFORMATION       0x20
>>> +#define UAC3_CHANNEL_AMBISONIC         0x21
>>> +#define UAC3_CHANNEL_DESCRIPTION       0x22
>>> +#define UAC3_CHANNEL_VENDOR_DEFINED    0xFE
>>> +#define UAC3_END_SEGMENT               0xFF
>>> +
>>> +/* A.11 CHANNEL PURPOSE DEFINITIONS */
>>> +#define UAC3_PURPOSE_UNDEFINED         0x00
>>> +#define UAC3_PURPOSE_GENERIC_AUDIO     0x01
>>> +#define UAC3_PURPOSE_VOICE             0x02
>>> +#define UAC3_PURPOSE_SPEECH            0x03
>>> +#define UAC3_PURPOSE_AMBIENT           0x04
>>> +#define UAC3_PURPOSE_REFERENCE         0x05
>>> +#define UAC3_PURPOSE_ULTRASONIC                0x06
>>> +#define UAC3_PURPOSE_VIBROKINETIC      0x07
>>> +#define UAC3_PURPOSE_NON_AUDIO         0xFF
>>> +
>>> +/* A.12 CHANNEL RELATIONSHIP DEFINITIONS */
>>> +/* FIXME: spec is missing these constants. Few found in
>>> BasicAudioDevice3.pdf */
>>
>>
>> yes, this is a known bug in the released UAC3 document, the values were
>> removed by accident. If this helps, here's what I have from the last release
>> candidate, this will hopefully be corrected soon.
> 
> My next step was to send a follow-up email to usb.org about this issue,
> but since you already have the answer, I'll include these values in the
> next version of patch, thanks.

It doesn't hurt to provide feedback to USB since it'll show the need for 
a spec update.

[snip]

>>
>>
>>> +#define UAC3_CH_RELATIONSHIP_UNDEFINED 0x00
>>> +#define UAC3_CH_MONO                   0x01
>>> +#define UAC3_CH_LEFT                   0x02
>>> +#define UAC3_CH_RIGHT                  0x03
>>> +#define UAC3_CH_FRONT_LEFT             0x80
>>> +#define UAC3_CH_FRONT_RIGHT            0x81
>>> +#define UAC3_CH_FRONT_CENTER           0x82
>>> +#define UAC3_CH_SURROUND_ARRAY_LEFT    0x89
>>> +#define UAC3_CH_SURROUND_ARRAY_RIGHT   0x8A
>>> +#define UAC3_CH_LOW_FREQUENCY_EFFECTS  0xB8
>>> +
>>> +/* A.15 AUDIO CLASS-SPECIFIC AC INTERFACE DESCRIPTOR SUBTYPES */
>>> +/* see audio.h for the rest, which is identical to v1 */
>>> +#define UAC3_EXTENDED_TERMINAL         0x04
>>> +#define UAC3_MIXER_UNIT                        0x05
>>> +#define UAC3_SELECTOR_UNIT             0x06
>>> +#define UAC3_FEATURE_UNIT              0x07
>>> +#define UAC3_EFFECT_UNIT               0x08
>>> +#define UAC3_PROCESSING_UNIT           0x09
>>> +#define UAC3_EXTENSION_UNIT            0x0a
>>> +#define UAC3_CLOCK_SOURCE              0x0b
>>> +#define UAC3_CLOCK_SELECTOR            0x0c
>>> +#define UAC3_CLOCK_MULTIPLIER          0x0d
>>> +#define UAC3_SAMPLE_RATE_CONVERTER     0x0e
>>> +#define UAC3_CONNECTORS                        0x0f
>>> +#define UAC3_POWER_DOMAIN              0x10
>>> +
>>> +/* A.22 AUDIO CLASS-SPECIFIC REQUEST CODES */
>>> +#define UAC3_CS_REQ_CUR                                0x01
>>> +#define UAC3_CS_REQ_RANGE                      0x02
>>> +#define UAC3_CS_REQ_MEM                                0x03
>>
>>
>> these first 3 are already in UAC2
>>
>>> +#define UAC3_CS_REQ_INTEN                      0x04
>>> +#define UAC3_CS_REQ_STRING                     0x05
>>> +#define UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR 0x06
>>
>>
>> the last 3 are really UAC3-specific
> 
> Tha'ts correct. Do you want to say we can reuse UAC2 values?
> This brings an issue I described previously in this mailing list.
> It is related to UAC1/2/3 specs has some common values, sometimes
> use different values for same things and this makes understanding
> of sources quite complex if for example we will use UAC2_xx for
> UAC3 in some cases for common things but UAC3_xx for UAC3-specifc.
> 
> I see 3 solutions:
> 1) use UAC2_xxx for common things (hard to read/write the code, you
>      have to remember what is common and what is not, or leave
>      a comment near each such place saying it's OK to use it for UAC3
> 2) rename UAC2_xxx to something like UAC_V2V3_xxx, so it will be
>      self-explanatory

I vote for this option.

> 3) create UAC3_xxx for thouse things that are common with UAC2,
>      so no need to do either 1 or 2, but it can lead to code duplication
> 
> In this patch I did some mix of 2 and 3, but additional comments are
> welcome, as it variabl naming is the hardest part of programming :)
>>
>>> +
>>> +/* A.23.1 AUDIOCONTROL INTERFACE CONTROL SELECTORS */
>>> +#define UAC3_AC_CONTROL_UNDEFINED              0x00
>>> +#define UAC3_AC_ACTIVE_INTERFACE_CONTROL       0x01
>>> +#define UAC3_AC_POWER_DOMAIN_CONTROL           0x02
>>> +
>>> +#endif /* __LINUX_USB_AUDIO_V3_H */
>>> diff --git a/include/uapi/linux/usb/audio.h
>>> b/include/uapi/linux/usb/audio.h
>>> index a4680a5..66ec2ae 100644
>>> --- a/include/uapi/linux/usb/audio.h
>>> +++ b/include/uapi/linux/usb/audio.h
>>> @@ -26,6 +26,7 @@
>>>    /* bInterfaceProtocol values to denote the version of the standard used
>>> */
>>>    #define UAC_VERSION_1                 0x00
>>>    #define UAC_VERSION_2                 0x20
>>> +#define UAC_VERSION_3                  0x30
>>>      /* A.2 Audio Interface Subclass Codes */
>>>    #define USB_SUBCLASS_AUDIOCONTROL     0x01
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 3dc36d9..df3f0ab 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -7,6 +7,7 @@
>>>     *        Alan Cox (alan@lxorguk.ukuu.org.uk)
>>>     *        Thomas Sailer (sailer@ife.ee.ethz.ch)
>>>     *
>>> + *   Audio Class 3.0 support by Ruslan Bilovol <ruslan.bilovol@gmail.com>
>>
>>
>> does this mean new copyright?
> 
> That's a good qestion, I don't know the answer. Just wanted to leave
> a comment about work I did for USB audio.

Don't know the answer either.

> 
>>
>>>     *
>>>     *   This program is free software; you can redistribute it and/or
>>> modify
>>>     *   it under the terms of the GNU General Public License as published
>>> by
>>> @@ -44,6 +45,7 @@
>>>    #include <linux/mutex.h>
>>>    #include <linux/usb/audio.h>
>>>    #include <linux/usb/audio-v2.h>
>>> +#include <linux/usb/audio-v3.h>
>>>    #include <linux/module.h>
>>>      #include <sound/control.h>
>>> @@ -261,7 +263,8 @@ static int snd_usb_create_streams(struct snd_usb_audio
>>> *chip, int ctrlif)
>>>                  break;
>>>          }
>>>    -     case UAC_VERSION_2: {
>>> +       case UAC_VERSION_2:
>>> +       case UAC_VERSION_3: {
>>>                  struct usb_interface_assoc_descriptor *assoc =
>>>                          usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
>>>    @@ -281,7 +284,7 @@ static int snd_usb_create_streams(struct
>>> snd_usb_audio *chip, int ctrlif)
>>>                  }
>>>                  if (!assoc) {
>>> -                       dev_err(&dev->dev, "Audio class v2 interfaces need
>>> an interface association\n");
>>> +                       dev_err(&dev->dev, "Audio class v2/v3 interfaces
>>> need an interface association\n");
>>
>>
>> yes, but they can have more than one, so how do you handle the selection
>> (see 3.3)?
> 
> Current implentation of USB audio driver is to create only one ALSA
> card per USB device, that works with UAC1/UAC2 and now with UAC3;
> so if USB device hase more that one interface association, only first
> will be used.
> 
> But if you mean configuration switching (between backward
> compatible UAC1/UAC2 and UAC3 configuration) that will not limit us,
> since after switching to another configuration  UAC1/UAC2 interfaces
> will be released and UAC3 will be probed, this is done by USB core.
> 
> As described above, currently I switching between configs manually.

My hope is that we can have a basic policy to select the configurations, 
as detailed above.

[snip]

> 
>>
>>
>>>    #include <sound/core.h>
>>>    #include <sound/pcm.h>
>>> @@ -39,11 +40,11 @@
>>>     * @dev: usb device
>>>     * @fp: audioformat record
>>>     * @format: the format tag (wFormatTag)
>>> - * @fmt: the format type descriptor
>>> + * @fmt: the format type descriptor (v1/v2) or AudioStreaming descriptor
>>> (v3)
>>>     */
>>>    static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
>>>                                       struct audioformat *fp,
>>> -                                    unsigned int format, void *_fmt)
>>> +                                    u64 format, void *_fmt)
>>>    {
>>>          int sample_width, sample_bytes;
>>>          u64 pcm_formats = 0;
>>> @@ -69,6 +70,17 @@ static u64 parse_audio_format_i_type(struct
>>> snd_usb_audio *chip,
>>>                  format <<= 1;
>>>                  break;
>>>          }
>>> +       case UAC_VERSION_3: {
>>> +               struct uac3_as_header_descriptor *as = _fmt;
>>> +               sample_width = as->bBitResolution;
>>> +               sample_bytes = as->bSubslotSize;
>>> +
>>> +               if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
>>> +                       pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
>>
>>
>> could this be expanded to add at least basic PCM (D0 set).
> 
> Basic PCM, and more (D0..D5) are handled, this is needed for special
> case of raw data, same as for UAC2, see commit 717bfb5 ("ALSA:
> snd-usb: handle raw data format of UAC2 devices")

I don't get this one, you are only handing D6 here? where is D0..D5 handled?

> 
>>
>>> +int snd_usb_parse_audio_format_v3(struct snd_usb_audio *chip,
>>> +                              struct audioformat *fp,
>>> +                              struct uac3_as_header_descriptor *as,
>>> +                              int stream)
>>> +{
>>> +       u64 format = le64_to_cpu(as->bmFormats);
>>> +       int err;
>>> +
>>> +       /* Type I format bits are D0..D6 */
>>> +       if (format & 0x7f)
>>> +               fp->fmt_type = UAC_FORMAT_TYPE_I;
>>> +       else
>>> +               fp->fmt_type = UAC_FORMAT_TYPE_III;
>>
>> maybe mention that this test only work because type IV is not supported,
>> otherwise this wouldn't quite right.
> 
> Yes, will do it.

ok

> 
>>
>>> +int snd_usb_parse_audio_format_v3(struct snd_usb_audio *chip,
>>> +                              struct audioformat *fp,
>>> +                              struct uac3_as_header_descriptor *as,
>>> +                              int stream);
>>>    #endif /*  __USBAUDIO_FORMAT_H */
>>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>>> index 9732edf..5b5dfe4 100644
>>> --- a/sound/usb/mixer.c
>>> +++ b/sound/usb/mixer.c
>>> @@ -51,6 +51,7 @@
>>>    #include <linux/usb.h>
>>>    #include <linux/usb/audio.h>
>>>    #include <linux/usb/audio-v2.h>
>>> +#include <linux/usb/audio-v3.h>
>>>      #include <sound/core.h>
>>>    #include <sound/control.h>
>>> @@ -189,7 +190,7 @@ static void *find_audio_control_unit(struct
>>> mixer_build *state,
>>>                                          USB_DT_CS_INTERFACE)) != NULL) {
>>>                  if (hdr->bLength >= 4 &&
>>>                      hdr->bDescriptorSubtype >= UAC_INPUT_TERMINAL &&
>>> -                   hdr->bDescriptorSubtype <= UAC2_SAMPLE_RATE_CONVERTER
>>> &&
>>> +                   hdr->bDescriptorSubtype <= UAC3_SAMPLE_RATE_CONVERTER
>>> &&
>>>                      hdr->bUnitID == unit)
>>
>>
>> this looks like a mistake, the definitions are
>>
>> #define UAC3_SAMPLE_RATE_CONVERTER      0x0e
>> #define UAC3_CONNECTORS                 0x0f
>> #define UAC3_POWER_DOMAIN               0x10
>>
>> You will miss the last two with this test.
> 
> That's because connectors descriptor uses High Capability descriptor for
> replresentation, thus it can't be compared here.
> Power Domain descriptor isn't used yet by this driver, so let's check for
> it once this functionality will be added.

Not sure I understand, the goal of this test is to check if the 
descriptors for the audio function look correct by looking at the range 
of their subType, which is also supported in High Capability descriptors?
> 
> Probably it makes sense to make this comparison UAC version depended
> to not break existing UAC1/2 functionality, I'll check it.
> 
>>
>>
>>> -               case UAC1_PROCESSING_UNIT:
>>> -               case UAC1_EXTENSION_UNIT:
>>> -               /* UAC2_PROCESSING_UNIT_V2 */
>>> -               /* UAC2_EFFECT_UNIT */
>>> -               case UAC2_EXTENSION_UNIT_V2: {
>>> -                       struct uac_processing_unit_descriptor *d = p1;
>>> -
>>> -                       if (state->mixer->protocol == UAC_VERSION_2 &&
>>> -                               hdr[2] == UAC2_EFFECT_UNIT) {
>>> -                               /* UAC2/UAC1 unit IDs overlap here in an
>>> -                                * uncompatible way. Ignore this unit for
>>> now.
>>> -                                */
>>> +
>>> +                               /* REVISIT: UAC3 IT doesn't have
>>> channels/cfg */
>>> +                               term->channels = 0;
>>> +                               term->chconfig = 0;
>>
>>
>> It does, but you need to get the information from the wClusterDescrID
> 
> Correct. Channels are used during mixer parsing which we don't support
> yet, chconfig is set in many places but nobody uses it, so we can remove it from
> usb_audio_term struct.

ok
