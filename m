From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: rawmidi problems
Date: Fri, 5 Jul 2002 19:30:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207051930.42945.plcl@telefonica.net>
References: <200207051753.54999.plcl@telefonica.net> <s5hhejeuo4c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhejeuo4c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

El Vie 05 Jul 2002 18:37, Takashi Iwai escribió:
> > I was trying to test rawmidi on snd-usb-midi with latest patches, with no
> > success :(
> >
> > Then, as I have an sb 128 (snd-ens1371) I tryed the alsa-lib/test/rawmidi
> > program with only that card module loaded.
>
> there might be still bugs on virmidi codes.
> i remember that it didn't work quite well on some conditions...
>
> will check later.

It works, sorry. I forgave the -v flag on rawmidi program :) Thanks everybody.

Now I am trying to test the oss midi emulation. MIDI Output works, but no 
input at all. I'm trying:
$ cat /dev/midi00 | od -x
(nothing happens, nor with /dev/snd/midiC0D0)

$ ls -l /dev/midi*
lrwxrwxrwx    1 root     audio          10 dic  4  2001 /dev/midi -> 
/dev/midi0
crw-------    1 plc      audio     14,   2 dic  4  2001 /dev/midi0
crw-------    1 plc      audio     14,   2 ago 30  2001 /dev/midi00
crw-------    1 plc      audio     14,  18 ago 30  2001 /dev/midi01
crw-------    1 plc      audio     14,  34 ago 30  2001 /dev/midi02
crw-------    1 plc      audio     14,  50 ago 30  2001 /dev/midi03
crw-------    1 plc      audio     14,  66 abr 18 20:17 /dev/midi04

Another question: I have a snd-ens1371 and two snd-usb-midi: a Roland/Edirol 
UM-2 and a Midiman Midisport 2x2. These are my modules.conf settings:

alias char-major-116 snd
alias char-major-14 soundcore
options snd snd_major=116 snd_cards_limit=3
alias snd-card-0 snd-ens1371
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
# ------------- USB MIDI ------------
alias snd-card-1 snd-usb-midi
alias sound-slot-1 snd-card-1
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-8 snd-seq-oss
alias snd-card-2 snd-usb-midi
alias sound-slot-2 snd-card-2
alias sound-service-2-1 snd-seq-oss
alias sound-service-2-8 snd-seq-oss

with /dev/midi00 ouput goes to ens-1371, /dev/midi01 goes to the first usb 
midi device, and /dev/midi02 goes to the second, but both usb devices have 2 
inputs ans 2 outputs. Can I get all my five midi ports work with oss midi 
emulation?

Thanks,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
