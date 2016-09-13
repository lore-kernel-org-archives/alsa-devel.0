From: Felipe Ferreri Tonello <eu@felipetonello.com>
Subject: Re: [v7 PATCH] amidi: add sysex-interval option
Date: Tue, 13 Sep 2016 14:53:27 +0100
Message-ID: <dbdfd6ad-5586-f3dc-3950-85974f783bef@felipetonello.com>
References: <20160830160248.4595-1-eu@felipetonello.com>
 <ceba2296-1973-0a6f-aa1e-8c04b9f533f0@felipetonello.com>
 <84e1a053-73bc-392b-4348-73ed26734ab4@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F89384322F39B4F4BE7567F7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id A1551266AA9
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 15:53:40 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id b184so2498856wma.3
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 06:53:40 -0700 (PDT)
In-Reply-To: <84e1a053-73bc-392b-4348-73ed26734ab4@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------F89384322F39B4F4BE7567F7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi Takashi,

On 13/09/16 00:32, Takashi Sakamoto wrote:
> Hi,
> 
> On Sep 13 2016 01:41, Felipe Ferreri Tonello wrote:
>> ping?
> 
> Sorry to be late. I've already read this patch, then consider about
> whether this patch is for general purporse or not.
> 
> The basic design of 'amidi' tool is somehow generic purpose;
> send/receive MIDI messages to/from ALSA rawmidi devices. In my opinion,
> model-specific features is not so preferable to this tool.
> 
> The system exclusive messages are for the purpose to implement
> vendor-dependent something. So if this patch is quite unique for a small
> part of devices, I think it better to add isolated tools with this
> feature from amidi.

This is not a vendor-dependent feature, by any means. This feature is
really useful for upgrading firmwares via SysEx, this is a very common
practice used by several devices.

There are other applications for other OSes that implements this
feature, that is why I saw the need for `amidi' to support, been so useful.

> 
> For my information and help of my review, please show which devices do
> you want to set up this tool?

Many devices uses this to update internal firmware, for example. I use
in the Seaboard RISE, Seaboard GRAND, Linnstrument, and so on.

> 
> Another my concern is a case that MIDI messages in a given file includes
> some messages except for system exclusives.

As suggested by Clemens Ladish, I implemented delays in between SysEx
only, because in practice that is what people use this feature for. But
even then, other types of MIDI messages will not cause any problem, it
will not be delayed.

> 
>> On 30/08/16 17:02, Felipe F. Tonello wrote:
>>> This patch adds a new option to amidi tool: sysex-interval.
>>>
>>> It adds a delay (in milliseconds) in between each SysEx message - it
>>> searches
>>> for a 0xF7 byte.
>>>
>>> This is very useful when sending firmware updates to a remote device
>>> via SysEx
>>> or any other use that requires this delay in between SysEx messages.
>>>
>>> `amidi' manual was updated with an example usage as well.
>>>
>>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>>> ---
>>>  amidi/amidi.1 | 16 ++++++++++-
>>>  amidi/amidi.c | 88
>>> +++++++++++++++++++++++++++++++++++++++++++++++------------
>>>  2 files changed, 86 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/amidi/amidi.1 b/amidi/amidi.1
>>> index 86beb27a1e3b..5bc24ba3ad54 100644
>>> --- a/amidi/amidi.1
>>> +++ b/amidi/amidi.1
>>> @@ -1,4 +1,4 @@
>>> -.TH AMIDI 1 "16 Apr 2016"
>>> +.TH AMIDI 1 "30 Aug 2016"
>>>
>>>  .SH NAME
>>>  amidi \- read from and write to ALSA RawMIDI ports
>>> @@ -120,6 +120,12 @@ received MIDI commands.
>>>  Does not ignore Clock bytes (F8h) when saving or printing received
>>>  MIDI commands.
>>>
>>> +.TP
>>> +.I \-i, \-\-sysex-interval=mseconds
>>> +Adds a delay in between each SysEx message sent to a device. It is
>>> +useful when sending firmware updates via SysEx messages to a remote
>>> +device.
>>> +
>>>  .SH EXAMPLES
>>>
>>>  .TP
>>> @@ -130,6 +136,14 @@ to port
>>>  .I hw:0.
>>>
>>>  .TP
>>> +.B amidi \-p hw:1,0,0 -s firmware.syx \-i 100
>>> +will send the MIDI commands in
>>> +.I firmware.syx
>>> +to port
>>> +.I hw:1,0,0
>>> +with 100 milliseconds delay in between each SysEx message.
>>> +
>>> +.TP
>>>  .B amidi \-S 'F0 43 10 4C 00 00 7E 00 F7'
>>>  sends an XG Reset to the default port.
>>>
>>> diff --git a/amidi/amidi.c b/amidi/amidi.c
>>> index c20512cc96a7..a8264f181cf3 100644
>>> --- a/amidi/amidi.c
>>> +++ b/amidi/amidi.c
>>> @@ -52,6 +52,7 @@ static int receive_file;
>>>  static int dump;
>>>  static float timeout;
>>>  static int stop;
>>> +static int sysex_interval;
>>>  static snd_rawmidi_t *input, **inputp;
>>>  static snd_rawmidi_t *output, **outputp;
>>>
>>> @@ -70,19 +71,20 @@ static void usage(void)
>>>      printf(
>>>          "Usage: amidi options\n"
>>>          "\n"
>>> -        "-h, --help             this help\n"
>>> -        "-V, --version          print current version\n"
>>> -        "-l, --list-devices     list all hardware ports\n"
>>> -        "-L, --list-rawmidis    list all RawMIDI definitions\n"
>>> -        "-p, --port=name        select port by name\n"
>>> -        "-s, --send=file        send the contents of a (.syx) file\n"
>>> -        "-r, --receive=file     write received data into a file\n"
>>> -        "-S, --send-hex=\"...\"   send hexadecimal bytes\n"
>>> -        "-d, --dump             print received data as hexadecimal
>>> bytes\n"
>>> -        "-t, --timeout=seconds  exits when no data has been received\n"
>>> -        "                       for the specified duration\n"
>>> -        "-a, --active-sensing   include active sensing bytes\n"
>>> -        "-c, --clock            include clock bytes\n");
>>> +        "-h, --help                      this help\n"
>>> +        "-V, --version                   print current version\n"
>>> +        "-l, --list-devices              list all hardware ports\n"
>>> +        "-L, --list-rawmidis             list all RawMIDI
>>> definitions\n"
>>> +        "-p, --port=name                 select port by name\n"
>>> +        "-s, --send=file                 send the contents of a
>>> (.syx) file\n"
>>> +        "-r, --receive=file              write received data into a
>>> file\n"
>>> +        "-S, --send-hex=\"...\"            send hexadecimal bytes\n"
>>> +        "-d, --dump                      print received data as
>>> hexadecimal bytes\n"
>>> +        "-t, --timeout=seconds           exits when no data has been
>>> received\n"
>>> +        "                                for the specified duration\n"
>>> +        "-a, --active-sensing            include active sensing
>>> bytes\n"
>>> +        "-c, --clock                     include clock bytes\n"
>>> +        "-i, --sysex-interval=mseconds   delay in between each SysEx
>>> message\n");
>>>  }
>>>
>>>  static void version(void)
>>> @@ -230,6 +232,47 @@ static void rawmidi_list(void)
>>>      snd_output_close(output);
>>>  }
>>>
>>> +static int send_midi_interleaved(void)
>>> +{
>>> +    int err;
>>> +    char *data = send_data;
>>> +    size_t buffer_size;
>>> +    snd_rawmidi_params_t *param;
>>> +    snd_rawmidi_status_t *st;
>>> +
>>> +    snd_rawmidi_status_alloca(&st);
>>> +
>>> +    snd_rawmidi_params_alloca(&param);
>>> +    snd_rawmidi_params_current(output, param);
>>> +    buffer_size = snd_rawmidi_params_get_buffer_size(param);
>>> +
>>> +    while (data < (send_data + send_data_length)) {
>>> +        int len = send_data + send_data_length - data;
>>> +        char *temp;
>>> +
>>> +        if (data > send_data) {
>>> +            snd_rawmidi_status(output, st);
>>> +            do {
>>> +                /* 320 µs per byte as noted in Page 1 of MIDI spec */
>>> +                usleep((buffer_size -
>>> snd_rawmidi_status_get_avail(st)) * 320);
>>> +                snd_rawmidi_status(output, st);
>>> +            } while(snd_rawmidi_status_get_avail(st) < buffer_size);
>>> +            usleep(sysex_interval * 1000);
>>> +        }
>>> +
>>> +        /* find end of SysEx */
>>> +        if ((temp = memchr(data, 0xf7, len)) != NULL)
>>> +            len = temp - data + 1;
>>> +
>>> +        if ((err = snd_rawmidi_write(output, data, len)) < 0)
>>> +            return err;
>>> +
>>> +        data += len;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  static void load_file(void)
>>>  {
>>>      int fd;
>>> @@ -411,7 +454,7 @@ static void add_send_hex_data(const char *str)
>>>
>>>  int main(int argc, char *argv[])
>>>  {
>>> -    static const char short_options[] = "hVlLp:s:r:S::dt:ac";
>>> +    static const char short_options[] = "hVlLp:s:r:S::dt:aci:";
>>>      static const struct option long_options[] = {
>>>          {"help", 0, NULL, 'h'},
>>>          {"version", 0, NULL, 'V'},
>>> @@ -425,6 +468,7 @@ int main(int argc, char *argv[])
>>>          {"timeout", 1, NULL, 't'},
>>>          {"active-sensing", 0, NULL, 'a'},
>>>          {"clock", 0, NULL, 'c'},
>>> +        {"sysex-interval", 1, NULL, 'i'},
>>>          { }
>>>      };
>>>      int c, err, ok = 0;
>>> @@ -474,6 +518,9 @@ int main(int argc, char *argv[])
>>>          case 'c':
>>>              ignore_clock = 0;
>>>              break;
>>> +        case 'i':
>>> +            sysex_interval = atoi(optarg);
>>> +            break;
>>>          default:
>>>              error("Try `amidi --help' for more information.");
>>>              return 1;
>>> @@ -549,9 +596,16 @@ int main(int argc, char *argv[])
>>>              error("cannot set blocking mode: %s", snd_strerror(err));
>>>              goto _exit;
>>>          }
>>> -        if ((err = snd_rawmidi_write(output, send_data,
>>> send_data_length)) < 0) {
>>> -            error("cannot send data: %s", snd_strerror(err));
>>> -            goto _exit;
>>> +        if (!sysex_interval) {
>>> +            if ((err = snd_rawmidi_write(output, send_data,
>>> send_data_length)) < 0) {
>>> +                error("cannot send data: %s", snd_strerror(err));
>>> +                return err;
>>> +            }
>>> +        } else {
>>> +            if ((err = send_midi_interleaved()) < 0) {
>>> +                error("cannot send data: %s", snd_strerror(err));
>>> +                return err;
>>> +            }
>>>          }
>>>      }
> 

-- 
Felipe

--------------F89384322F39B4F4BE7567F7
Content-Type: application/pgp-keys;
 name="0x92698E6A.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x92698E6A.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SkAyCfQaSw=3D=3D
=3DJwBB
-----END PGP PUBLIC KEY BLOCK-----

--------------F89384322F39B4F4BE7567F7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------F89384322F39B4F4BE7567F7--
