From: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Subject: Re: AUDIOPHILE 2496 and SBLIVE with ALSA
Date: Sat, 18 May 2002 00:04:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020518000419.C3550@fliwatut.scifi>
References: <9960f242b67630470e2c2b375c54b3db@www1.mail.volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <9960f242b67630470e2c2b375c54b3db@www1.mail.volny.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

pavelni@volny.cz hat gesagt: // pavelni@volny.cz wrote:

> I would like to ask for advices about how to setup
> the cards AUDIOPHILE 2496 and SBLIVE to be able to use
> at the same time (ALSA).

Here's my modules.conf, I have the same setup:

# START
alias char-major-116 snd
alias char-major-14 soundcore
options snd snd_major=116 snd_cards_limit=3 snd_device_mode=0660 snd_device_gid=29 snd_device_uid=0

# Midiman
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# SBLive
alias sound-slot-1 snd-card-1
alias sound-service-1-0 snd-mixer-oss
#alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
#alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

# VirMIDI
alias sound-slot-2 snd-card-2
#alias sound-service-2-1 snd-seq-oss
#alias sound-service-2-8 snd-seq-oss

#alias snd-card-0 snd-card-ice1712
alias snd-card-0 snd-ice1712
options snd-card-ice1712 snd_index=0 snd_enable

#alias snd-card-1 snd-card-emu10k1
alias snd-card-1 snd-emu10k1
options snd-card-emu10k1 snd_enable

#alias snd-card-2 snd-card-virmidi
alias snd-card-2 snd-virmidi

post-install snd-synth-emu10k1 /usr/bin/sfxload /dos/audio/sblive/SFBank/8mbgmsfx.sf2
# END

-- 
 Frank Barknecht                               _ ______footils.org__

_______________________________________________________________

Hundreds of nodes, one monster rendering program.
Now that’s a super model! Visit http://clustering.foundries.sf.net/
