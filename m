From: Cameron Hutchison <camh+alsa@xdna.net>
Subject: ens1371/ac97 broken on my machine
Date: Wed, 21 May 2003 16:34:08 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030521063408.GA11993@imladris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The driver for the ens1371 chipset no longer works on my laptop.
It used to work in version 0.9.0rc3, but in version 0.9.2 and 0.93a, it
no longer works. When I try to run alsamixer, I get the error "No mixer
elems found"

Details:
  Distribution: Debian GNU/Linux (unstable)
  Kernel: Linux 2.4.19, 2.4.20, 2.4.21rc2
  Alsa kernel version: 0.9.2, 0.9.3a
  lspci output (with and without -n):
    00:09.0 Class 0401: 1102:8938
    00:09.0 Multimedia audio controller: Creative Labs ES1371

I've tracked the issue back to the AC97 codec where it creates the mixer
elements (in function snd_ac97_mixer(), file ac97_codec.c), in
particular, this piece of code:

        /* test for AC'97 */
        /* test if we can write to the record gain volume register */
        snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x8a06);
        if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a06) {
                ac97->scaps |= AC97_SCAP_AUDIO;
                ac97->caps = snd_ac97_read(ac97, AC97_RESET);
                ac97->ext_id = snd_ac97_read(ac97, AC97_EXTENDED_ID);
                if (ac97->ext_id == 0xffff)     /* invalid combination */
                        ac97->ext_id = 0;
        }

It seems that snd_ac97_read() does not read back the value 0x8a06 and
never sets AC97_SCAP_AUDIO, which means the mixer elements never get 
created.

I've successfully used this sound hardware with alsa for the last three
years.

Can anyone help?



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
