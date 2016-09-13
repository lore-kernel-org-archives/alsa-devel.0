From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [v7 PATCH] amidi: add sysex-interval option
Date: Wed, 14 Sep 2016 02:44:06 +0900
Message-ID: <bd1656a5-cb69-02d9-d449-0f93897b8124@sakamocchi.jp>
References: <20160830160248.4595-1-eu@felipetonello.com>
 <ceba2296-1973-0a6f-aa1e-8c04b9f533f0@felipetonello.com>
 <84e1a053-73bc-392b-4348-73ed26734ab4@sakamocchi.jp>
 <dbdfd6ad-5586-f3dc-3950-85974f783bef@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 0E2E726048C
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 19:44:11 +0200 (CEST)
In-Reply-To: <dbdfd6ad-5586-f3dc-3950-85974f783bef@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sep 13 2016 22:53, Felipe Ferreri Tonello wrote:
> Hi Takashi,
> =

> On 13/09/16 00:32, Takashi Sakamoto wrote:
>> Hi,
>>
>> On Sep 13 2016 01:41, Felipe Ferreri Tonello wrote:
>>> ping?
>>
>> Sorry to be late. I've already read this patch, then consider about
>> whether this patch is for general purporse or not.
>>
>> The basic design of 'amidi' tool is somehow generic purpose;
>> send/receive MIDI messages to/from ALSA rawmidi devices. In my opinion,
>> model-specific features is not so preferable to this tool.
>>
>> The system exclusive messages are for the purpose to implement
>> vendor-dependent something. So if this patch is quite unique for a small
>> part of devices, I think it better to add isolated tools with this
>> feature from amidi.
> =

> This is not a vendor-dependent feature, by any means. This feature is
> really useful for upgrading firmwares via SysEx, this is a very common
> practice used by several devices.
> =

> There are other applications for other OSes that implements this
> feature, that is why I saw the need for `amidi' to support, been so usefu=
l.

Hm. If the MIDI messages you want to handle were vendor-independent, it
would probably be 'universal system exclusive' or described in some
recommended practices (RPs). But your patch comment don't address to
them. At least, I find no public documents for your purpose. So I can't
avoid to judge the feature is for something dependent to vendors.

>> For my information and help of my review, please show which devices do
>> you want to set up this tool?
> =

> Many devices uses this to update internal firmware, for example. I use
> in the Seaboard RISE, Seaboard GRAND, Linnstrument, and so on.

If vendors voluntarily expand the specification then the expansion is
widely used and practices in fact, it was better to describe it to your
patch comment, to help reviewers.

>> Another my concern is a case that MIDI messages in a given file includes
>> some messages except for system exclusives.
> =

> As suggested by Clemens Ladish, I implemented delays in between SysEx
> only, because in practice that is what people use this feature for. But
> even then, other types of MIDI messages will not cause any problem, it
> will not be delayed.

I mean this case:
<F0>...<F7> <no exclusive messages such like note> <F0>...<F7> <ditto>
<F0>...<F7>

In this case, I think your code includes ambiguities to handle messages
between each system exclusives. For upgrading firmwares on MIDI devices,
the non-exclusive messages should not be transferred, perhaps, to
protect the devices from disorder. In this view, I addressed to split
this feature to independent tool to amidi.

Anyway, this patch was applied to upstream.

>>> On 30/08/16 17:02, Felipe F. Tonello wrote:
>>>> This patch adds a new option to amidi tool: sysex-interval.
>>>>
>>>> It adds a delay (in milliseconds) in between each SysEx message - it
>>>> searches
>>>> for a 0xF7 byte.
>>>>
>>>> This is very useful when sending firmware updates to a remote device
>>>> via SysEx
>>>> or any other use that requires this delay in between SysEx messages.
>>>>
>>>> `amidi' manual was updated with an example usage as well.
>>>>
>>>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>>>> ---
>>>>  amidi/amidi.1 | 16 ++++++++++-
>>>>  amidi/amidi.c | 88
>>>> +++++++++++++++++++++++++++++++++++++++++++++++------------
>>>>  2 files changed, 86 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/amidi/amidi.1 b/amidi/amidi.1
>>>> index 86beb27a1e3b..5bc24ba3ad54 100644
>>>> --- a/amidi/amidi.1
>>>> +++ b/amidi/amidi.1
>>>> @@ -1,4 +1,4 @@
>>>> -.TH AMIDI 1 "16 Apr 2016"
>>>> +.TH AMIDI 1 "30 Aug 2016"
>>>>
>>>>  .SH NAME
>>>>  amidi \- read from and write to ALSA RawMIDI ports
>>>> @@ -120,6 +120,12 @@ received MIDI commands.
>>>>  Does not ignore Clock bytes (F8h) when saving or printing received
>>>>  MIDI commands.
>>>>
>>>> +.TP
>>>> +.I \-i, \-\-sysex-interval=3Dmseconds
>>>> +Adds a delay in between each SysEx message sent to a device. It is
>>>> +useful when sending firmware updates via SysEx messages to a remote
>>>> +device.
>>>> +
>>>>  .SH EXAMPLES
>>>>
>>>>  .TP
>>>> @@ -130,6 +136,14 @@ to port
>>>>  .I hw:0.
>>>>
>>>>  .TP
>>>> +.B amidi \-p hw:1,0,0 -s firmware.syx \-i 100
>>>> +will send the MIDI commands in
>>>> +.I firmware.syx
>>>> +to port
>>>> +.I hw:1,0,0
>>>> +with 100 milliseconds delay in between each SysEx message.
>>>> +
>>>> +.TP
>>>>  .B amidi \-S 'F0 43 10 4C 00 00 7E 00 F7'
>>>>  sends an XG Reset to the default port.
>>>>
>>>> diff --git a/amidi/amidi.c b/amidi/amidi.c
>>>> index c20512cc96a7..a8264f181cf3 100644
>>>> --- a/amidi/amidi.c
>>>> +++ b/amidi/amidi.c
>>>> @@ -52,6 +52,7 @@ static int receive_file;
>>>>  static int dump;
>>>>  static float timeout;
>>>>  static int stop;
>>>> +static int sysex_interval;
>>>>  static snd_rawmidi_t *input, **inputp;
>>>>  static snd_rawmidi_t *output, **outputp;
>>>>
>>>> @@ -70,19 +71,20 @@ static void usage(void)
>>>>      printf(
>>>>          "Usage: amidi options\n"
>>>>          "\n"
>>>> -        "-h, --help             this help\n"
>>>> -        "-V, --version          print current version\n"
>>>> -        "-l, --list-devices     list all hardware ports\n"
>>>> -        "-L, --list-rawmidis    list all RawMIDI definitions\n"
>>>> -        "-p, --port=3Dname        select port by name\n"
>>>> -        "-s, --send=3Dfile        send the contents of a (.syx) file\=
n"
>>>> -        "-r, --receive=3Dfile     write received data into a file\n"
>>>> -        "-S, --send-hex=3D\"...\"   send hexadecimal bytes\n"
>>>> -        "-d, --dump             print received data as hexadecimal
>>>> bytes\n"
>>>> -        "-t, --timeout=3Dseconds  exits when no data has been receive=
d\n"
>>>> -        "                       for the specified duration\n"
>>>> -        "-a, --active-sensing   include active sensing bytes\n"
>>>> -        "-c, --clock            include clock bytes\n");
>>>> +        "-h, --help                      this help\n"
>>>> +        "-V, --version                   print current version\n"
>>>> +        "-l, --list-devices              list all hardware ports\n"
>>>> +        "-L, --list-rawmidis             list all RawMIDI
>>>> definitions\n"
>>>> +        "-p, --port=3Dname                 select port by name\n"
>>>> +        "-s, --send=3Dfile                 send the contents of a
>>>> (.syx) file\n"
>>>> +        "-r, --receive=3Dfile              write received data into a
>>>> file\n"
>>>> +        "-S, --send-hex=3D\"...\"            send hexadecimal bytes\n"
>>>> +        "-d, --dump                      print received data as
>>>> hexadecimal bytes\n"
>>>> +        "-t, --timeout=3Dseconds           exits when no data has been
>>>> received\n"
>>>> +        "                                for the specified duration\n"
>>>> +        "-a, --active-sensing            include active sensing
>>>> bytes\n"
>>>> +        "-c, --clock                     include clock bytes\n"
>>>> +        "-i, --sysex-interval=3Dmseconds   delay in between each SysEx
>>>> message\n");
>>>>  }
>>>>
>>>>  static void version(void)
>>>> @@ -230,6 +232,47 @@ static void rawmidi_list(void)
>>>>      snd_output_close(output);
>>>>  }
>>>>
>>>> +static int send_midi_interleaved(void)
>>>> +{
>>>> +    int err;
>>>> +    char *data =3D send_data;
>>>> +    size_t buffer_size;
>>>> +    snd_rawmidi_params_t *param;
>>>> +    snd_rawmidi_status_t *st;
>>>> +
>>>> +    snd_rawmidi_status_alloca(&st);
>>>> +
>>>> +    snd_rawmidi_params_alloca(&param);
>>>> +    snd_rawmidi_params_current(output, param);
>>>> +    buffer_size =3D snd_rawmidi_params_get_buffer_size(param);
>>>> +
>>>> +    while (data < (send_data + send_data_length)) {
>>>> +        int len =3D send_data + send_data_length - data;
>>>> +        char *temp;
>>>> +
>>>> +        if (data > send_data) {
>>>> +            snd_rawmidi_status(output, st);
>>>> +            do {
>>>> +                /* 320 =B5s per byte as noted in Page 1 of MIDI spec =
*/
>>>> +                usleep((buffer_size -
>>>> snd_rawmidi_status_get_avail(st)) * 320);
>>>> +                snd_rawmidi_status(output, st);
>>>> +            } while(snd_rawmidi_status_get_avail(st) < buffer_size);
>>>> +            usleep(sysex_interval * 1000);
>>>> +        }
>>>> +
>>>> +        /* find end of SysEx */
>>>> +        if ((temp =3D memchr(data, 0xf7, len)) !=3D NULL)
>>>> +            len =3D temp - data + 1;
>>>> +
>>>> +        if ((err =3D snd_rawmidi_write(output, data, len)) < 0)
>>>> +            return err;
>>>> +
>>>> +        data +=3D len;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>  static void load_file(void)
>>>>  {
>>>>      int fd;
>>>> @@ -411,7 +454,7 @@ static void add_send_hex_data(const char *str)
>>>>
>>>>  int main(int argc, char *argv[])
>>>>  {
>>>> -    static const char short_options[] =3D "hVlLp:s:r:S::dt:ac";
>>>> +    static const char short_options[] =3D "hVlLp:s:r:S::dt:aci:";
>>>>      static const struct option long_options[] =3D {
>>>>          {"help", 0, NULL, 'h'},
>>>>          {"version", 0, NULL, 'V'},
>>>> @@ -425,6 +468,7 @@ int main(int argc, char *argv[])
>>>>          {"timeout", 1, NULL, 't'},
>>>>          {"active-sensing", 0, NULL, 'a'},
>>>>          {"clock", 0, NULL, 'c'},
>>>> +        {"sysex-interval", 1, NULL, 'i'},
>>>>          { }
>>>>      };
>>>>      int c, err, ok =3D 0;
>>>> @@ -474,6 +518,9 @@ int main(int argc, char *argv[])
>>>>          case 'c':
>>>>              ignore_clock =3D 0;
>>>>              break;
>>>> +        case 'i':
>>>> +            sysex_interval =3D atoi(optarg);
>>>> +            break;
>>>>          default:
>>>>              error("Try `amidi --help' for more information.");
>>>>              return 1;
>>>> @@ -549,9 +596,16 @@ int main(int argc, char *argv[])
>>>>              error("cannot set blocking mode: %s", snd_strerror(err));
>>>>              goto _exit;
>>>>          }
>>>> -        if ((err =3D snd_rawmidi_write(output, send_data,
>>>> send_data_length)) < 0) {
>>>> -            error("cannot send data: %s", snd_strerror(err));
>>>> -            goto _exit;
>>>> +        if (!sysex_interval) {
>>>> +            if ((err =3D snd_rawmidi_write(output, send_data,
>>>> send_data_length)) < 0) {
>>>> +                error("cannot send data: %s", snd_strerror(err));
>>>> +                return err;
>>>> +            }
>>>> +        } else {
>>>> +            if ((err =3D send_midi_interleaved()) < 0) {
>>>> +                error("cannot send data: %s", snd_strerror(err));
>>>> +                return err;
>>>> +            }
>>>>          }
>>>>      }
