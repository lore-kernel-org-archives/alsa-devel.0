From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ALSA: usb: initial USB Audio Device
 Class 3.0 support
Date: Sat, 11 Nov 2017 04:48:49 +0200
Message-ID: <CAB=otbRrJ5oCs-ggfMh4i_UZAbCrMwV5aAeVZgFOnNLric_=NQ@mail.gmail.com>
References: <1510020080-15849-1-git-send-email-ruslan.bilovol@gmail.com>
 <1510020080-15849-2-git-send-email-ruslan.bilovol@gmail.com> <a7815f69-d300-ea47-2a64-b69261a2c5e1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a7815f69-d300-ea47-2a64-b69261a2c5e1@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 8, 2017 at 9:38 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> Nice work, thanks! I double-checked all the descriptors and values and
> didn't find anything problematic, the main comment I have is that the clock
> source/selection could probably be refactored since the differences are
> really minor with UAC2, and there is work to do to select the right Audio
> Interface Association.
>
> On 11/6/17 8:01 PM, Ruslan Bilovol wrote:
>>
>> Recently released USB Audio Class 3.0 specification
>> introduces many significant changes comparing to
>> previous versions, like
>>   - new Power Domains, support for LPM/L1
>>   - new Cluster descriptor
>>   - changed layout of all class-specific descriptors
>>   - new High Capability descriptors
>>   - New class-specific String descriptors
>>   - new and removed units
>>   - additional sources for interrupts
>>   - removed Type II Audio Data Formats
>>   - ... and many other things (check spec)
>>
>> It also provides backward compatibility through
>> multiple configurations, as well as requires
>> mandatory support for BADD (Basic Audio Device
>> Definition) on each ADC3.0 compliant device
>>
>> This patch adds initial support of UAC3 specification
>> that is enough for Generic I/O Profile (BAOF, BAIF)
>> device support from BADD document.
>
>
> Do you mean to say that the selection of the BADD profile or full-blown
> descriptor capabilities will be handled in a follow-up patch?

I have no follow-up patch for configuration switching.
I mean only that it is enough to support BAOF, BAIF profiles.
however, BAIOF profile won't work correctly, becaus it contains mixer unit
which is not supported yet in this patch.

This is because of way I use UAC3. As UAC3 device, I use an UAC3
gadget implementation which I sent before to linux-usb mailing list:
http://www.spinics.net/lists/linux-usb/msg162482.html

The UAC3 gadget implements BAOF+BAIF profile; but not BAIOF profile
which doesn't make sense in this case (there is no reason to mix Audio IN
with Audio Out)

Thus I can't implement and test UAC3 mixer handling in current patch,
so BAIOF profile isn't supported by it yet.

>
> It's my understanding from Section 3.3 that a UAC3 device is required to
> expose
> - a backwards-compatible configuration (UAC1 or UAC2),
> - a UAC3 BADD profile
> - one or more AIA compliant with UAC3 (which may have additional features
> not present in the baseline description).

My understanding of Section 3.3 is slightly different. An UAC3 device is
required to expose:
 - a backward-compatible first configuration (UAC1 or UAC2)
 - an UAC3 BADD profile on another configuration, with only one AIA inside
 - and _may_ have one or more configurations with UAC3 support that
   provide functionality beyond what is available in BADD

>
> And I am not sure how a driver would make the selection...

In order to test this patch, I created UAC2+UAC3 gadget and manually
switched to UAC3 configuration on Host by:
$ echo 2 > /sys/bus/usb/devices/1-1/bConfigurationValue

I don't think ALSA driver can make decision which configuration to select,
maybe some userspace tool can handle it, like usb_modeswitch does
for networking devices.

>
> In theory though, a UAC3 device should work out of the box even if the host
> only supports UAC1 or UAC2.

Yes, this is correct, I verified it as well.

>
>
>> +/*
>> + * v1.0, v2.0 and v3.0 of this standard have many things in common. For
>> the rest
>> + * of the definitions, please refer to audio.h and audio-v2.h
>> + */
>> +
>> +/* All High Capability descriptors have these 2 fields at the beginning
>> */
>> +struct uac3_hc_descriptor_header {
>> +       __le16 wLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __le16 wDescriptorID;
>> +} __attribute__ ((packed));
>> +
>> +/* 4.3.1 CLUSTER DESCRIPTOR HEADER */
>> +struct uac3_cluster_header_descriptor {
>> +       __le16 wLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __le16 wDescriptorID;
>> +       __u8 bNrChannels;
>> +} __attribute__ ((packed));
>> +
>> +/* 4.3.2.1 SEGMENTS */
>> +struct uac3_cluster_segment_descriptor {
>> +       __le16 wLength;
>> +       __u8 bSegmentType;
>> +       /* __u8[0]; segment-specific data */
>> +} __attribute__ ((packed));
>> +
>> +/* 4.3.2.1.1 END SEGMENT */
>> +struct uac3_cluster_end_segment_descriptor {
>> +       __le16 wLength;
>> +       __u8 bSegmentType;              /* Constant END_SEGMENT */
>> +} __attribute__ ((packed));
>> +
>
>
> you didn't include the definitions in 4.3.2.1.2
> Cluster Descriptor Segment
> Vendor Defined Segment

Correct, they are not used in BADD so I didn't care much, but I can
add it in next patchset

>
>> +/* 4.3.2.1.3.1 INFORMATION SEGMENT */
>> +struct uac3_cluster_information_segment_descriptor {
>> +       __le16 wLength;
>> +       __u8 bSegmentType;
>
>
> this field is a CHANNEL_INFORMATION constant.
>
>> +       __u8 bChPurpose;
>> +       __u8 bChRelationship;
>> +       __u8 bChGroupID;
>> +} __attribute__ ((packed));
>> +
>> +/* 4.5.2 CLASS-SPECIFIC AC INTERFACE DESCRIPTOR */
>> +struct uac3_ac_header_descriptor {
>> +       __u8 bLength;                   /* 10 */
>> +       __u8 bDescriptorType;           /* CS_INTERFACE descriptor type */
>> +       __u8 bDescriptorSubtype;        /* HEADER descriptor subtype */
>> +       __u8 bCategory;
>> +
>> +       /* includes Clock Source, Unit, Terminal, and Power Domain desc.
>> */
>> +       __le16 wTotalLength;
>> +
>> +       __le32 bmControls;
>> +} __attribute__ ((packed));
>> +
>
>
> Missing extended terminal descriptor header from 4.5.2.3.2?
>
> Missing multi-function processing unit descriptor header from 4.5.2.10.3 ?

Yes, I can add them as well.

>
>> +
>> +/* bmAttribute fields */
>> +#define UAC3_CLOCK_SOURCE_TYPE_EXT     0x0
>> +#define UAC3_CLOCK_SOURCE_TYPE_INT     0x1
>> +#define UAC3_CLOCK_SOURCE_ASYNC                (0 << 2)
>> +#define UAC3_CLOCK_SOURCE_SYNCED_TO_SOF        (1 << 1)
>> +
>> +/* 4.5.2.13 CLOCK SELECTOR DESCRIPTOR */
>> +struct uac3_clock_selector_descriptor {
>> +       __u8 bLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __u8 bClockID;
>> +       __u8 bNrInPins;
>> +       __u8 baCSourceID[];
>> +       /* bmControls and wCSelectorDescrStr omitted */
>
>
> why is this omitted here and not below in the clock multiplier descriptor?

That's because in this descriptor ther is variable (unknown) field baCSourceID,
so we can't define anythyng else after it as per C standard.
In the clock multiplier descriptor below we don't have such issue.

>
>> +} __attribute__((packed) > +
>> +/* 4.5.2.14 CLOCK MULTIPLIER DESCRIPTOR */
>> +struct uac3_clock_multiplier_descriptor {
>> +       __u8 bLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __u8 bClockID;
>> +       __u8 bCSourceID;
>> +       __le32 bmControls;
>> +       __le16 wCMultiplierDescrStr;
>> +} __attribute__((packed));
>
>
> [snip]
>
>> +
>> +/* 4.5.2.15 POWER DOMAIN DESCRIPTOR */
>> +struct uac3_power_domain_descriptor {
>> +       __u8 bLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __u8 bPowerDomainID;
>> +       __le16 waRecoveryTime1;
>> +       __le16 waRecoveryTime2;
>> +       __u8 bNrEntities;
>> +       __u8 baEntityID[];
>> +       /* wPDomainDescrStr omitted */
>
> why?
>>
>> +} __attribute__((packed));
>> +
>> +/* As above, but more useful for defining your own descriptors */
>> +#define DECLARE_UAC3_POWER_DOMAIN_DESCRIPTOR(n)                        \
>> +struct uac3_power_domain_descriptor_##n {                      \
>> +       __u8 bLength;                                           \
>> +       __u8 bDescriptorType;                                   \
>> +       __u8 bDescriptorSubtype;                                \
>> +       __u8 bPowerDomainID;                                    \
>> +       __le16 waRecoveryTime1;                                 \
>> +       __le16 waRecoveryTime2;                                 \
>> +       __u8 bNrEntities;                                       \
>> +       __u8 baEntityID[n];                                     \
>> +       __le16 wPDomainDescrStr;                                        \
>> +} __attribute__ ((packed))
>> +
>
>
> any specific reason why the descriptors are not added in linear order,
> following the spec definition? all the descriptors below could be added
> earlier.

That's because of way I wrote this header. These descritors are added
in same order as in UAC2 header, then it was more easy to compare
both headers in order to understand if we can reuse anything from UAC2.

If course I should reorganize it, but forgot to do :D

>
>> +/* 4.5.2.1 INPUT TERMINAL DESCRIPTOR */
>> +struct uac3_input_terminal_descriptor {
>> +       __u8 bLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __u8 bTerminalID;
>> +       __le16 wTerminalType;
>> +       __u8 bAssocTerminal;
>> +       __u8 bCSourceID;
>> +       __le32 bmControls;
>> +       __le16 wClusterDescrID;
>> +       __le16 wExTerminalDescrID;
>> +       __le16 wConnectorsDescrID;
>> +       __le16 wTerminalDescrStr;
>> +} __attribute__((packed));
>> +
>
>
>> +
>> +/* 4.7.2 CLASS-SPECIFIC AS INTERFACE DESCRIPTOR */
>> +struct uac3_as_header_descriptor {
>> +       __u8 bLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __u8 bTerminalLink;
>> +       __le32 bmControls;
>> +       __le16 wClusterDescrID;
>> +       __le64 bmFormats;
>> +       __u8 bSubslotSize;
>> +       __u8 bBitResolution;
>> +       __le16 bmAuxProtocols;
>> +       __u8 bControlSize;
>> +} __attribute__((packed));
>> +
>> +#define UAC3_FORMAT_TYPE_I_RAW_DATA    (1 << 6)
>
> This seems to come from Table A1 in the formats document, is it inserted
> here because of the relationship with the bmFormats? If yes, we should
> probably add the full list from Table A1 (as done below for the other codes)

Yes, this comes from Frmts3.0. However, for bits 0..5 we reuse same
values from UAC1 spec, thay are same for UAC2 as well.
See UAC_FORMAT_TYPE_xxx

>
>> +
>> +/* 4.8.1.2 CLASS-SPECIFIC AS ISOCHRONOUS AUDIO DATA ENDPOINT DESCRIPTOR
>> */
>> +struct uac3_iso_endpoint_descriptor {
>> +       __u8 bLength;
>> +       __u8 bDescriptorType;
>> +       __u8 bDescriptorSubtype;
>> +       __le32 bmControls;
>> +       __u8 bLockDelayUnits;
>> +       __le16 wLockDelay;
>> +} __attribute__((packed));
>> +
>> +#define UAC3_CONTROL_PITCH             (3 << 0)
>> +#define UAC3_CONTROL_DATA_OVERRUN      (3 << 2)
>> +#define UAC3_CONTROL_DATA_UNDERRUN     (3 << 4)
>
>
> these are really masks, no?

Yes, same as in UAC2, we can drop them as they are not used yet.

>
>> +
>> +/* 6.1 INTERRUPT DATA MESSAGE */
>> +#define UAC3_INTERRUPT_DATA_MSG_VENDOR (1 << 0)
>> +#define UAC3_INTERRUPT_DATA_MSG_EP     (1 << 1)
>
>
> this is the same as in UAC2
>
>> +
>> +struct uac3_interrupt_data_msg {
>> +       __u8 bInfo;
>> +       __u8 bSourceType;
>> +       __le16 wValue;
>> +       __le16 wIndex;
>> +} __attribute__((packed));
>
>
> This seems identical to UAC2, the difference being the bSourceType with
> additional values (was bAttribute).

Yes, this is correct. I made separate structure just to make code reading
easier. Same is for UAC3_INTERRUPT_DATA_xxx above.

>
>> +
>> +/* A.2 AUDIO AUDIO FUNCTION SUBCLASS CODES */
>> +#define UAC3_FUNCTION_SUBCLASS_UNDEFINED       0x00
>> +#define UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0    0x01
>> +#define UAC3_FUNCTION_SUBCLASS_GENERIC_IO      0x20
>> +#define UAC3_FUNCTION_SUBCLASS_HEADPHONE       0x21
>> +#define UAC3_FUNCTION_SUBCLASS_SPEAKER         0x22
>> +#define UAC3_FUNCTION_SUBCLASS_MICROPHONE      0x23
>> +#define UAC3_FUNCTION_SUBCLASS_HEADSET         0x24
>> +#define UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER 0x25
>> +#define UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE    0x26
>
>
> mention that these are linked to BADD profiles.

OK, will do it

>
>> +
>> +/* A.7 AUDIO FUNCTION CATEGORY CODES */
>> +#define UAC3_FUNCTION_SUBCLASS_UNDEFINED       0x00
>> +#define UAC3_FUNCTION_DESKTOP_SPEAKER          0x01
>> +#define UAC3_FUNCTION_HOME_THEATER             0x02
>> +#define UAC3_FUNCTION_MICROPHONE               0x03
>> +#define UAC3_FUNCTION_HEADSET                  0x04
>> +#define UAC3_FUNCTION_TELEPHONE                        0x05
>> +#define UAC3_FUNCTION_CONVERTER                        0x06
>> +#define UAC3_FUNCTION_SOUND_RECORDER           0x07
>> +#define UAC3_FUNCTION_IO_BOX                   0x08
>> +#define UAC3_FUNCTION_MUSICAL_INSTRUMENT       0x09
>> +#define UAC3_FUNCTION_PRO_AUDIO                        0x0a
>> +#define UAC3_FUNCTION_AUDIO_VIDEO              0x0b
>> +#define UAC3_FUNCTION_CONTROL_PANEL            0x0c
>> +#define UAC3_FUNCTION_HEADPHONE                        0x0d
>> +#define UAC3_FUNCTION_GENERIC_SPEAKER          0x0e
>> +#define UAC3_FUNCTION_HEADSET_ADAPTER          0x0f
>> +#define UAC3_FUNCTION_SPEAKERPHONE             0x10
>> +#define UAC3_FUNCTION_OTHER                    0xff
>> +
>> +/* A.8 AUDIO CLASS-SPECIFIC DESCRIPTOR TYPES */
>> +#define UAC3_CS_UNDEFINED              0x20
>> +#define UAC3_CS_DEVICE                 0x21
>> +#define UAC3_CS_CONFIGURATION          0x22
>> +#define UAC3_CS_STRING                 0x23
>> +#define UAC3_CS_INTERFACE              0x24
>> +#define UAC3_CS_ENDPOINT               0x25
>> +#define UAC3_CS_CLUSTER                        0x26
>> +
>> +/* A.10 CLUSTER DESCRIPTOR SEGMENT TYPES */
>> +#define UAC3_SEGMENT_UNDEFINED         0x00
>> +#define UAC3_CLUSTER_DESCRIPTION       0x01
>> +#define UAC3_CLUSTER_VENDOR_DEFINED    0x1F
>> +#define UAC3_CHANNEL_INFORMATION       0x20
>> +#define UAC3_CHANNEL_AMBISONIC         0x21
>> +#define UAC3_CHANNEL_DESCRIPTION       0x22
>> +#define UAC3_CHANNEL_VENDOR_DEFINED    0xFE
>> +#define UAC3_END_SEGMENT               0xFF
>> +
>> +/* A.11 CHANNEL PURPOSE DEFINITIONS */
>> +#define UAC3_PURPOSE_UNDEFINED         0x00
>> +#define UAC3_PURPOSE_GENERIC_AUDIO     0x01
>> +#define UAC3_PURPOSE_VOICE             0x02
>> +#define UAC3_PURPOSE_SPEECH            0x03
>> +#define UAC3_PURPOSE_AMBIENT           0x04
>> +#define UAC3_PURPOSE_REFERENCE         0x05
>> +#define UAC3_PURPOSE_ULTRASONIC                0x06
>> +#define UAC3_PURPOSE_VIBROKINETIC      0x07
>> +#define UAC3_PURPOSE_NON_AUDIO         0xFF
>> +
>> +/* A.12 CHANNEL RELATIONSHIP DEFINITIONS */
>> +/* FIXME: spec is missing these constants. Few found in
>> BasicAudioDevice3.pdf */
>
>
> yes, this is a known bug in the released UAC3 document, the values were
> removed by accident. If this helps, here's what I have from the last release
> candidate, this will hopefully be corrected soon.

My next step was to send a follow-up email to usb.org about this issue,
but since you already have the answer, I'll include these values in the
next version of patch, thanks.

>
>
> RELATIONSHIP_UNDEFINED     UND  0x00
> MONO                       M    0x01
> LEFT                       L    0x02
> RIGHT                      R    0x03
> ARRAY                      AR   0x04
> PATTERN_X                  PX   0x20
> PATTERN_Y                  PY   0x21
> PATTERN_A                  PA   0x22
> PATTERN_B                  PB   0x23
> PATTERN_M                  PM   0x24
> PATTERN_S                  PS   0x25
> Front Left                 FL   0x80
> Front Right                FR   0x81
> Front Center               FC   0x82
> Front Left of Center       FLC  0x83
> Front Right of Center      FRC  0x84
> Front Wide Left            FWL  0x85
> Front Wide Right           FWR  0x86
> Side Left                  SL   0x87
> Side Right                 SR   0x88
> Surround Array Left        SAL  0x89
> Surround Array Right       SAR  0x8A
>
> Back Left                      BL      0x8B
> Back Right                     BR      0x8C
> Back Center                    BC      0x8D
> Back Left of Center            BLC     0x8E
> Back Right of Center           BRC     0x8F
> Back Wide Left                 BWL     0x90
> Back Wide Right                BWR     0x91
> Top Center                     TC      0x92
> Top Front Left                 TFL     0x93
> Top Front Right                TFR     0x94
> Top Front Center               TFC     0x95
> Top Front Left of Center       TFLC    0x96
> Top Front Right of Center      TFRC    0x97
> Top Front Wide Left            TFWL    0x98
> Top Front Wide Right           TFWR    0x99
> Top Side Left                  TSL     0x9A
> Top Side Right                 TSR     0x9B
> Top Surround Array Left        TSAL    0x9C
> Top Surround Array Right       TSAR    0x9D
> Top Back Left                  TBL     0x9E
> Top Back Right                 TBR     0x9F
> Top Back Center                TBC     0xA0
> Top Back Left Of Center        TBLC    0xA1
> Top Back Right Of Center       TBRC    0xA2
> Top Back Wide Left             TBWL    0xA3
> Top Back Wide Right            TBWR    0xA4
> Bottom Center                  BC      0xA5
> Bottom Front Left              BFL     0xA6
> Bottom Front Right             BFR     0xA7
> Bottom Front Center            BFC     0xA8
> Bottom Front Left Of Center    BFLC    0xA9
> Bottom Front Right Of Center   BFRC    0xAA
> Bottom Front Wide Left         BFWL    0xAB
> Bottom Front Wide Right        BFWR    0xAC
>
> Bottom Side Left             BSL    0xAD
> Bottom Side Right            BSR    0xAE
> Bottom Surround Array Left   BSAL   0xAF
> Bottom Surround Array Right  BSAR   0xB0
> Bottom Back Left             BBL    0xB1
> Bottom Back Right            BBR    0xB2
> Bottom Back Center           BBC    0xB3
> Bottom Back Left Of Center   BBLC   0xB4
> Bottom Back Right Of Center  BBRC   0xB5
> Bottom Back Wide Left        BBWL   0xB6
> Bottom Back Wide Right       BBWR   0xB7
> Low Frequency Effects        LFE    0xB8
> Low Frequency Effects Left   LFEL   0xB9
> Low Frequency Effects Right  LFER   0xBA
> Headphone Left               HPL    0xBB
> Headphone Right              HPR    0xBC
>
>
>> +#define UAC3_CH_RELATIONSHIP_UNDEFINED 0x00
>> +#define UAC3_CH_MONO                   0x01
>> +#define UAC3_CH_LEFT                   0x02
>> +#define UAC3_CH_RIGHT                  0x03
>> +#define UAC3_CH_FRONT_LEFT             0x80
>> +#define UAC3_CH_FRONT_RIGHT            0x81
>> +#define UAC3_CH_FRONT_CENTER           0x82
>> +#define UAC3_CH_SURROUND_ARRAY_LEFT    0x89
>> +#define UAC3_CH_SURROUND_ARRAY_RIGHT   0x8A
>> +#define UAC3_CH_LOW_FREQUENCY_EFFECTS  0xB8
>> +
>> +/* A.15 AUDIO CLASS-SPECIFIC AC INTERFACE DESCRIPTOR SUBTYPES */
>> +/* see audio.h for the rest, which is identical to v1 */
>> +#define UAC3_EXTENDED_TERMINAL         0x04
>> +#define UAC3_MIXER_UNIT                        0x05
>> +#define UAC3_SELECTOR_UNIT             0x06
>> +#define UAC3_FEATURE_UNIT              0x07
>> +#define UAC3_EFFECT_UNIT               0x08
>> +#define UAC3_PROCESSING_UNIT           0x09
>> +#define UAC3_EXTENSION_UNIT            0x0a
>> +#define UAC3_CLOCK_SOURCE              0x0b
>> +#define UAC3_CLOCK_SELECTOR            0x0c
>> +#define UAC3_CLOCK_MULTIPLIER          0x0d
>> +#define UAC3_SAMPLE_RATE_CONVERTER     0x0e
>> +#define UAC3_CONNECTORS                        0x0f
>> +#define UAC3_POWER_DOMAIN              0x10
>> +
>> +/* A.22 AUDIO CLASS-SPECIFIC REQUEST CODES */
>> +#define UAC3_CS_REQ_CUR                                0x01
>> +#define UAC3_CS_REQ_RANGE                      0x02
>> +#define UAC3_CS_REQ_MEM                                0x03
>
>
> these first 3 are already in UAC2
>
>> +#define UAC3_CS_REQ_INTEN                      0x04
>> +#define UAC3_CS_REQ_STRING                     0x05
>> +#define UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR 0x06
>
>
> the last 3 are really UAC3-specific

Tha'ts correct. Do you want to say we can reuse UAC2 values?
This brings an issue I described previously in this mailing list.
It is related to UAC1/2/3 specs has some common values, sometimes
use different values for same things and this makes understanding
of sources quite complex if for example we will use UAC2_xx for
UAC3 in some cases for common things but UAC3_xx for UAC3-specifc.

I see 3 solutions:
1) use UAC2_xxx for common things (hard to read/write the code, you
    have to remember what is common and what is not, or leave
    a comment near each such place saying it's OK to use it for UAC3
2) rename UAC2_xxx to something like UAC_V2V3_xxx, so it will be
    self-explanatory
3) create UAC3_xxx for thouse things that are common with UAC2,
    so no need to do either 1 or 2, but it can lead to code duplication

In this patch I did some mix of 2 and 3, but additional comments are
welcome, as it variabl naming is the hardest part of programming :)
>
>> +
>> +/* A.23.1 AUDIOCONTROL INTERFACE CONTROL SELECTORS */
>> +#define UAC3_AC_CONTROL_UNDEFINED              0x00
>> +#define UAC3_AC_ACTIVE_INTERFACE_CONTROL       0x01
>> +#define UAC3_AC_POWER_DOMAIN_CONTROL           0x02
>> +
>> +#endif /* __LINUX_USB_AUDIO_V3_H */
>> diff --git a/include/uapi/linux/usb/audio.h
>> b/include/uapi/linux/usb/audio.h
>> index a4680a5..66ec2ae 100644
>> --- a/include/uapi/linux/usb/audio.h
>> +++ b/include/uapi/linux/usb/audio.h
>> @@ -26,6 +26,7 @@
>>   /* bInterfaceProtocol values to denote the version of the standard used
>> */
>>   #define UAC_VERSION_1                 0x00
>>   #define UAC_VERSION_2                 0x20
>> +#define UAC_VERSION_3                  0x30
>>     /* A.2 Audio Interface Subclass Codes */
>>   #define USB_SUBCLASS_AUDIOCONTROL     0x01
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 3dc36d9..df3f0ab 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -7,6 +7,7 @@
>>    *        Alan Cox (alan@lxorguk.ukuu.org.uk)
>>    *        Thomas Sailer (sailer@ife.ee.ethz.ch)
>>    *
>> + *   Audio Class 3.0 support by Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
>
> does this mean new copyright?

That's a good qestion, I don't know the answer. Just wanted to leave
a comment about work I did for USB audio.

>
>>    *
>>    *   This program is free software; you can redistribute it and/or
>> modify
>>    *   it under the terms of the GNU General Public License as published
>> by
>> @@ -44,6 +45,7 @@
>>   #include <linux/mutex.h>
>>   #include <linux/usb/audio.h>
>>   #include <linux/usb/audio-v2.h>
>> +#include <linux/usb/audio-v3.h>
>>   #include <linux/module.h>
>>     #include <sound/control.h>
>> @@ -261,7 +263,8 @@ static int snd_usb_create_streams(struct snd_usb_audio
>> *chip, int ctrlif)
>>                 break;
>>         }
>>   -     case UAC_VERSION_2: {
>> +       case UAC_VERSION_2:
>> +       case UAC_VERSION_3: {
>>                 struct usb_interface_assoc_descriptor *assoc =
>>                         usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
>>   @@ -281,7 +284,7 @@ static int snd_usb_create_streams(struct
>> snd_usb_audio *chip, int ctrlif)
>>                 }
>>                 if (!assoc) {
>> -                       dev_err(&dev->dev, "Audio class v2 interfaces need
>> an interface association\n");
>> +                       dev_err(&dev->dev, "Audio class v2/v3 interfaces
>> need an interface association\n");
>
>
> yes, but they can have more than one, so how do you handle the selection
> (see 3.3)?

Current implentation of USB audio driver is to create only one ALSA
card per USB device, that works with UAC1/UAC2 and now with UAC3;
so if USB device hase more that one interface association, only first
will be used.

But if you mean configuration switching (between backward
compatible UAC1/UAC2 and UAC3 configuration) that will not limit us,
since after switching to another configuration  UAC1/UAC2 interfaces
will be released and UAC3 will be probed, this is done by USB core.

As described above, currently I switching between configs manually.

>
>>                         return -EINVAL;
>>                 }
>>   diff --git a/sound/usb/card.h b/sound/usb/card.h
>> index 111b0f0..5e2934f 100644
>> --- a/sound/usb/card.h
>> +++ b/sound/usb/card.h
>> @@ -21,7 +21,7 @@ struct audioformat {
>>         unsigned char endpoint;         /* endpoint */
>>         unsigned char ep_attr;          /* endpoint attributes */
>>         unsigned char datainterval;     /* log_2 of data packet interval
>> */
>> -       unsigned char protocol;         /* UAC_VERSION_1/2 */
>> +       unsigned char protocol;         /* UAC_VERSION_1/2/3 */
>>         unsigned int maxpacksize;       /* max. packet size */
>>         unsigned int rates;             /* rate bitmasks */
>>         unsigned int rate_min, rate_max;        /* min/max rates */
>> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
>> index 26dd5f2..04361d7 100644
>> --- a/sound/usb/clock.c
>> +++ b/sound/usb/clock.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/usb.h>
>>   #include <linux/usb/audio.h>
>>   #include <linux/usb/audio-v2.h>
>> +#include <linux/usb/audio-v3.h>
>>     #include <sound/core.h>
>>   #include <sound/info.h>
>> @@ -50,6 +51,22 @@
>>         return NULL;
>>   }
>>   +static struct uac3_clock_source_descriptor *
>> +       snd_usb_find_clock_source_v3(struct usb_host_interface
>> *ctrl_iface,
>> +                                 int clock_id)
>> +{
>> +       struct uac3_clock_source_descriptor *cs = NULL;
>> +
>> +       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
>> +                                            ctrl_iface->extralen,
>> +                                            cs, UAC3_CLOCK_SOURCE))) {
>> +               if (cs->bClockID == clock_id)
>> +                       return cs;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>   static struct uac_clock_selector_descriptor *
>>         snd_usb_find_clock_selector(struct usb_host_interface *ctrl_iface,
>>                                     int clock_id)
>> @@ -66,6 +83,22 @@
>>         return NULL;
>>   }
>>   +static struct uac3_clock_selector_descriptor *
>> +       snd_usb_find_clock_selector_v3(struct usb_host_interface
>> *ctrl_iface,
>> +                                   int clock_id)
>> +{
>> +       struct uac3_clock_selector_descriptor *cs = NULL;
>> +
>> +       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
>> +                                            ctrl_iface->extralen,
>> +                                            cs, UAC3_CLOCK_SELECTOR))) {
>> +               if (cs->bClockID == clock_id)
>> +                       return cs;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>   static struct uac_clock_multiplier_descriptor *
>>         snd_usb_find_clock_multiplier(struct usb_host_interface
>> *ctrl_iface,
>>                                       int clock_id)
>> @@ -82,6 +115,22 @@
>>         return NULL;
>>   }
>>   +static struct uac3_clock_multiplier_descriptor *
>> +       snd_usb_find_clock_multiplier_v3(struct usb_host_interface
>> *ctrl_iface,
>> +                                     int clock_id)
>> +{
>> +       struct uac3_clock_multiplier_descriptor *cs = NULL;
>> +
>> +       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
>> +                                            ctrl_iface->extralen,
>> +                                            cs, UAC3_CLOCK_MULTIPLIER)))
>> {
>> +               if (cs->bClockID == clock_id)
>> +                       return cs;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>   static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int
>> selector_id)
>>   {
>>         unsigned char buf;
>> @@ -135,19 +184,33 @@ static int uac_clock_selector_set_val(struct
>> snd_usb_audio *chip, int selector_i
>>         return ret;
>>   }
>>   -static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int
>> source_id)
>> +static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
>> +                                     int protocol,
>> +                                     int source_id)
>>   {
>>         int err;
>>         unsigned char data;
>>         struct usb_device *dev = chip->dev;
>> -       struct uac_clock_source_descriptor *cs_desc =
>> -               snd_usb_find_clock_source(chip->ctrl_intf, source_id);
>> -
>> -       if (!cs_desc)
>> -               return 0;
>> +       u32 bmControls;
>> +
>> +       if (protocol == UAC_VERSION_3) {
>> +               struct uac3_clock_source_descriptor *cs_desc =
>> +                       snd_usb_find_clock_source_v3(chip->ctrl_intf,
>> source_id);
>> +
>> +               if (!cs_desc)
>> +                       return 0;
>> +               bmControls = le32_to_cpu(cs_desc->bmControls);
>> +       } else { /* UAC_VERSION_1/2 */
>
>
> no, clock sources are only in UAC2.

Correct, will fix in next patch set

>
>> +               struct uac_clock_source_descriptor *cs_desc =
>> +                       snd_usb_find_clock_source(chip->ctrl_intf,
>> source_id);
>> +
>> +               if (!cs_desc)
>> +                       return 0;
>> +               bmControls = cs_desc->bmControls;
>> +       }
>>         /* If a clock source can't tell us whether it's valid, we assume
>> it is */
>> -       if (!uac2_control_is_readable(cs_desc->bmControls,
>> +       if (!uac_v2v3_control_is_readable(bmControls,
>>                                       UAC2_CS_CONTROL_CLOCK_VALID - 1))
>>                 return 1;
>>   @@ -167,9 +230,8 @@ static bool uac_clock_source_is_valid(struct
>> snd_usb_audio *chip, int source_id)
>>         return !!data;
>>   }
>>   -static int __uac_clock_find_source(struct snd_usb_audio *chip,
>> -                                  int entity_id, unsigned long *visited,
>> -                                  bool validate)
>> +static int __uac_clock_find_source(struct snd_usb_audio *chip, int
>> entity_id,
>> +                                  unsigned long *visited, bool validate)
>>   {
>>         struct uac_clock_source_descriptor *source;
>>         struct uac_clock_selector_descriptor *selector;
>> @@ -188,7 +250,8 @@ static int __uac_clock_find_source(struct
>> snd_usb_audio *chip,
>>         source = snd_usb_find_clock_source(chip->ctrl_intf, entity_id);
>>         if (source) {
>>                 entity_id = source->bClockID;
>> -               if (validate && !uac_clock_source_is_valid(chip,
>> entity_id)) {
>> +               if (validate && !uac_clock_source_is_valid(chip,
>> UAC_VERSION_2,
>> +
>> entity_id)) {
>>                         usb_audio_err(chip,
>>                                 "clock source %d is not valid, cannot
>> use\n",
>>                                 entity_id);
>> @@ -257,6 +320,97 @@ static int __uac_clock_find_source(struct
>> snd_usb_audio *chip,
>>         return -EINVAL;
>>   }
>>   +static int __uac3_clock_find_source(struct snd_usb_audio *chip, int
>> entity_id,
>> +                                  unsigned long *visited, bool validate)
>> +{
>> +       struct uac3_clock_source_descriptor *source;
>> +       struct uac3_clock_selector_descriptor *selector;
>> +       struct uac3_clock_multiplier_descriptor *multiplier;
>> +
>> +       entity_id &= 0xff;
>> +
>> +       if (test_and_set_bit(entity_id, visited)) {
>> +               usb_audio_warn(chip,
>> +                        "%s(): recursive clock topology detected, id
>> %d.\n",
>> +                        __func__, entity_id);
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* first, see if the ID we're looking for is a clock source
>> already */
>> +       source = snd_usb_find_clock_source_v3(chip->ctrl_intf, entity_id);
>> +       if (source) {
>> +               entity_id = source->bClockID;
>> +               if (validate && !uac_clock_source_is_valid(chip,
>> UAC_VERSION_3,
>> +
>> entity_id)) {
>> +                       usb_audio_err(chip,
>> +                               "clock source %d is not valid, cannot
>> use\n",
>> +                               entity_id);
>> +                       return -ENXIO;
>> +               }
>> +               return entity_id;
>> +       }
>> +
>> +       selector = snd_usb_find_clock_selector_v3(chip->ctrl_intf,
>> entity_id);
>> +       if (selector) {
>> +               int ret, i, cur;
>> +
>> +               /* the entity ID we are looking for is a selector.
>> +                * find out what it currently selects */
>> +               ret = uac_clock_selector_get_val(chip,
>> selector->bClockID);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               /* Selector values are one-based */
>> +
>> +               if (ret > selector->bNrInPins || ret < 1) {
>> +                       usb_audio_err(chip,
>> +                               "%s(): selector reported illegal value, id
>> %d, ret %d\n",
>> +                               __func__, selector->bClockID, ret);
>> +
>> +                       return -EINVAL;
>> +               }
>> +
>> +               cur = ret;
>> +               ret = __uac3_clock_find_source(chip,
>> selector->baCSourceID[ret - 1],
>> +                                              visited, validate);
>> +               if (!validate || ret > 0 || !chip->autoclock)
>> +                       return ret;
>> +
>> +               /* The current clock source is invalid, try others. */
>> +               for (i = 1; i <= selector->bNrInPins; i++) {
>> +                       int err;
>> +
>> +                       if (i == cur)
>> +                               continue;
>> +
>> +                       ret = __uac3_clock_find_source(chip,
>> selector->baCSourceID[i - 1],
>> +                               visited, true);
>> +                       if (ret < 0)
>> +                               continue;
>> +
>> +                       err = uac_clock_selector_set_val(chip, entity_id,
>> i);
>> +                       if (err < 0)
>> +                               continue;
>> +
>> +                       usb_audio_info(chip,
>> +                                "found and selected valid clock source
>> %d\n",
>> +                                ret);
>> +                       return ret;
>> +               }
>> +
>> +               return -ENXIO;
>> +       }
>> +
>> +       /* FIXME: multipliers only act as pass-thru element for now */
>> +       multiplier = snd_usb_find_clock_multiplier_v3(chip->ctrl_intf,
>> +                                                     entity_id);
>> +       if (multiplier)
>> +               return __uac3_clock_find_source(chip,
>> multiplier->bCSourceID,
>> +                                               visited, validate);
>> +
>> +       return -EINVAL;
>
>
> the difference between clock structures is not that big really between UAC2
> and UAC3 (wider bmcontrols, change to reference terminal and
> wClockSourceStr_), could this code be refactored to handle both UAC2 and
> UAC3?

Yes, that's the issue I described above. Will see what I can do here.

>
>
>> +}
>> +
>>   /*
>>    * For all kinds of sample rate settings and other device queries,
>>    * the clock source (end-leaf) must be used. However, clock selectors,
>> @@ -268,12 +422,22 @@ static int __uac_clock_find_source(struct
>> snd_usb_audio *chip,
>>    *
>>    * Returns the clock source UnitID (>=0) on success, or an error.
>>    */
>> -int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id,
>> -                             bool validate)
>> +int snd_usb_clock_find_source(struct snd_usb_audio *chip, int protocol,
>> +                             int entity_id, bool validate)
>>   {
>>         DECLARE_BITMAP(visited, 256);
>>         memset(visited, 0, sizeof(visited));
>> -       return __uac_clock_find_source(chip, entity_id, visited,
>> validate);
>> +
>> +       switch (protocol) {
>> +       case UAC_VERSION_2:
>> +               return __uac_clock_find_source(chip, entity_id, visited,
>> +                                              validate);
>> +       case UAC_VERSION_3:
>> +               return __uac3_clock_find_source(chip, entity_id, visited,
>> +                                              validate);
>
>
> this looks again very similar, could this be optimized?

Same here

>
>
>>   #include <sound/core.h>
>>   #include <sound/pcm.h>
>> @@ -39,11 +40,11 @@
>>    * @dev: usb device
>>    * @fp: audioformat record
>>    * @format: the format tag (wFormatTag)
>> - * @fmt: the format type descriptor
>> + * @fmt: the format type descriptor (v1/v2) or AudioStreaming descriptor
>> (v3)
>>    */
>>   static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
>>                                      struct audioformat *fp,
>> -                                    unsigned int format, void *_fmt)
>> +                                    u64 format, void *_fmt)
>>   {
>>         int sample_width, sample_bytes;
>>         u64 pcm_formats = 0;
>> @@ -69,6 +70,17 @@ static u64 parse_audio_format_i_type(struct
>> snd_usb_audio *chip,
>>                 format <<= 1;
>>                 break;
>>         }
>> +       case UAC_VERSION_3: {
>> +               struct uac3_as_header_descriptor *as = _fmt;
>> +               sample_width = as->bBitResolution;
>> +               sample_bytes = as->bSubslotSize;
>> +
>> +               if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
>> +                       pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
>
>
> could this be expanded to add at least basic PCM (D0 set).

Basic PCM, and more (D0..D5) are handled, this is needed for special
case of raw data, same as for UAC2, see commit 717bfb5 ("ALSA:
snd-usb: handle raw data format of UAC2 devices")

>
>> +int snd_usb_parse_audio_format_v3(struct snd_usb_audio *chip,
>> +                              struct audioformat *fp,
>> +                              struct uac3_as_header_descriptor *as,
>> +                              int stream)
>> +{
>> +       u64 format = le64_to_cpu(as->bmFormats);
>> +       int err;
>> +
>> +       /* Type I format bits are D0..D6 */
>> +       if (format & 0x7f)
>> +               fp->fmt_type = UAC_FORMAT_TYPE_I;
>> +       else
>> +               fp->fmt_type = UAC_FORMAT_TYPE_III;
>
> maybe mention that this test only work because type IV is not supported,
> otherwise this wouldn't quite right.

Yes, will do it.

>
>> +int snd_usb_parse_audio_format_v3(struct snd_usb_audio *chip,
>> +                              struct audioformat *fp,
>> +                              struct uac3_as_header_descriptor *as,
>> +                              int stream);
>>   #endif /*  __USBAUDIO_FORMAT_H */
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 9732edf..5b5dfe4 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -51,6 +51,7 @@
>>   #include <linux/usb.h>
>>   #include <linux/usb/audio.h>
>>   #include <linux/usb/audio-v2.h>
>> +#include <linux/usb/audio-v3.h>
>>     #include <sound/core.h>
>>   #include <sound/control.h>
>> @@ -189,7 +190,7 @@ static void *find_audio_control_unit(struct
>> mixer_build *state,
>>                                         USB_DT_CS_INTERFACE)) != NULL) {
>>                 if (hdr->bLength >= 4 &&
>>                     hdr->bDescriptorSubtype >= UAC_INPUT_TERMINAL &&
>> -                   hdr->bDescriptorSubtype <= UAC2_SAMPLE_RATE_CONVERTER
>> &&
>> +                   hdr->bDescriptorSubtype <= UAC3_SAMPLE_RATE_CONVERTER
>> &&
>>                     hdr->bUnitID == unit)
>
>
> this looks like a mistake, the definitions are
>
> #define UAC3_SAMPLE_RATE_CONVERTER      0x0e
> #define UAC3_CONNECTORS                 0x0f
> #define UAC3_POWER_DOMAIN               0x10
>
> You will miss the last two with this test.

That's because connectors descriptor uses High Capability descriptor for
replresentation, thus it can't be compared here.
Power Domain descriptor isn't used yet by this driver, so let's check for
it once this functionality will be added.

Probably it makes sense to make this comparison UAC version depended
to not break existing UAC1/2 functionality, I'll check it.

>
>
>> -               case UAC1_PROCESSING_UNIT:
>> -               case UAC1_EXTENSION_UNIT:
>> -               /* UAC2_PROCESSING_UNIT_V2 */
>> -               /* UAC2_EFFECT_UNIT */
>> -               case UAC2_EXTENSION_UNIT_V2: {
>> -                       struct uac_processing_unit_descriptor *d = p1;
>> -
>> -                       if (state->mixer->protocol == UAC_VERSION_2 &&
>> -                               hdr[2] == UAC2_EFFECT_UNIT) {
>> -                               /* UAC2/UAC1 unit IDs overlap here in an
>> -                                * uncompatible way. Ignore this unit for
>> now.
>> -                                */
>> +
>> +                               /* REVISIT: UAC3 IT doesn't have
>> channels/cfg */
>> +                               term->channels = 0;
>> +                               term->chconfig = 0;
>
>
> It does, but you need to get the information from the wClusterDescrID

Correct. Channels are used during mixer parsing which we don't support
yet, chconfig is set in many places but nobody uses it, so we can remove it from
usb_audio_term struct.

>
> [snip]
>
>> +/* UAC3 device stores channels information in Cluster Descriptors */
>> +static struct
>> +snd_pcm_chmap_elem *convert_chmap_v3(struct
>> uac3_cluster_header_descriptor
>> +                                                               *cluster)
>> +{
>> +       unsigned int channels = cluster->bNrChannels;
>> +       struct snd_pcm_chmap_elem *chmap;
>> +       void *p = cluster;
>> +       int len, c;
>> +
>> +       if (channels > ARRAY_SIZE(chmap->map))
>> +               return NULL;
>> +
>> +       chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
>> +       if (!chmap)
>> +               return NULL;
>> +
>> +       len = le16_to_cpu(cluster->wLength);
>> +       c = 0;
>> +       p += sizeof(struct uac3_cluster_header_descriptor);
>> +
>> +       while (((p - (void *)cluster) < len) && (c < channels)) {
>> +               struct uac3_cluster_segment_descriptor *cs_desc = p;
>> +               u16 cs_len;
>> +               u8 cs_type;
>> +
>> +               cs_len = le16_to_cpu(cs_desc->wLength);
>> +               cs_type = cs_desc->bSegmentType;
>> +
>> +               if (cs_type == UAC3_CHANNEL_INFORMATION) {
>> +                       struct uac3_cluster_information_segment_descriptor
>> *is = p;
>> +                       unsigned char map;
>> +
>> +                       /*
>> +                        * FIXME: this conversion is simplified, because
>> +                        * asound.h doesn't have UAC3 values yet
>
>
>
> yes, we need to have a mapping between USB and CEA definitions (which are
> aligned to some extent btw)
>
>> +                        */
>> +                       switch (is->bChPurpose) {
>> +                       case UAC3_CH_MONO:
>> +                               map = SNDRV_CHMAP_MONO;
>> +                               break;
>> +                       case UAC3_CH_LEFT:
>> +                       case UAC3_CH_FRONT_LEFT:
>> +                       case UAC3_CH_SURROUND_ARRAY_LEFT:
>> +                               map = SNDRV_CHMAP_FL;
>> +                               break;
>> +                       case UAC3_CH_RIGHT:
>> +                       case UAC3_CH_FRONT_RIGHT:
>> +                       case UAC3_CH_SURROUND_ARRAY_RIGHT:
>> +                               map = SNDRV_CHMAP_FR;
>> +                               break;
>> +                       case UAC3_CH_FRONT_CENTER:
>> +                               map = SNDRV_CHMAP_FC;
>> +                               break;
>> +                       case UAC3_CH_LOW_FREQUENCY_EFFECTS:
>> +                               map = SNDRV_CHMAP_LFE;
>> +                               break;
>> +                       case UAC3_CH_RELATIONSHIP_UNDEFINED:
>> +                       default:
>> +                               map = SNDRV_CHMAP_UNKNOWN;
>> +                               break;


Best regards,
Ruslan Bilovol
