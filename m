From: patrick reardon <swpatrick@earthlink.net>
Subject: Re: possible problems with rc6 aplay
Date: Mon, 16 Dec 2002 16:53:25 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFE5965.90F4A8B7@earthlink.net>
References: <200212151910.18nLEb5ck3NZFjX0@robin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

paul davis wrote:
>
> does any of this make it any clearer? its really a bit of problem that
> the rate setting code doesn't do a full 100% check on all this
> stuff. an app can set the rate to 44100, and appear to have succeeded,
> but it will have no difference on the actual rate if the sync source
> is not the clock's internal clock. this is true, btw, for most digital
> cards. if you tried to record at 44100, but your external converters
> were running at 48kHz (as you suggest they have been), then the
> recordings will be at 48kHz with the sync source set as shown above.

yes, thnx, it's much clearer now.  my converter is external with no rate switches and from
the manual i just discovered it always operates at 48000 (Alesis AI-3).  i'm still
uncertain how to change the card's configuration though.  "alsactl" doesn't seem to
provide an obvious way to do this (looking at the man page).  but my asound.state file has

--------------------snip--------------------
        control.8 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 'IEC958 In'
                comment.item.1 'ADAT1 In'
                comment.item.2 'ADAT2 In'
                iface PCM
                name 'Preferred Sync Source'
                value 'ADAT1 In'
	}
--------------------snip--------------------

do i just edit this by hand, changing value 'ADAT1 In' to value 'master', or ........ ??  

patrick



Paul Davis wrote:
> 
> >Latency: 4096 samples (2 periods of 16384 bytes)
> >Hardware pointer (frames): 0
> >Passthru: no
> >Clock mode: autosync
> >Pref. sync source: ADAT1
> >
> >IEC958 input: Coaxial
> >IEC958 output: Coaxial only
> >IEC958 quality: Consumer
> >IEC958 emphasis: off
> >IEC958 Dolby: off
> >IEC958 sample rate: error flag set
> >
> >ADAT Sample rate: 44100Hz
> 
> if you're hammerfall is configured as shown above (and no, the name
> change makes no difference), then the SR that it uses will be
> determined by your external converter connected to the first ADAT
> port. nothing that ALSA does (or any program using ALSA does) will
> alter the SR. thats because you are synced to ADAT1, not the card's
> internal clock, thus the SR is determined by the clock signal arriving
> at ADAT1, which presumably comes from a converter somewhere back up
> the ADAT chain.
> 
> its been on my to-do list for some time to make "master" the default
> clock mode on the hammerfall, which avoids any ambiguity about the
> sample rate used by the card. i've held back because its really not
> the right option for most studio-ish users, who have external
> converters that probably have rate switches on them and they expect
> the hammerfall to follow the switch setting.
> 
> --p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
