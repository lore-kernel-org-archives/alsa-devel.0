From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Wed, 19 Mar 2003 18:14:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
References: <s5hfzpjs38t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA14125
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2003 18:14:42 +0100
In-Reply-To: <s5hfzpjs38t.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Mar 2003, Takashi Iwai wrote:

> At Wed, 19 Mar 2003 17:49:51 +0100 (CET),
> Jaroslav wrote:
> > 
> > Hi all,
> > 
> > 	the dmix plugin was extended to support channel bindings and 
> > mixing code for 32-bit samples (24-bit resolution).
> > 	I'd like to introduce new two plugins (seems also "most wanted" by
> > ALSA users): dsnoop and dshare. The dsnoop plugin allows spliting of one
> > stream to more applications. And finally the dshare plugin does sharing of
> > channels (thus you may use your multi-channel device for separated
> > independent tasks). The ALSA configuration syntax for both of new plugins
> > is same as for the dmix plugin. Please note that dshare plugin must have
> > the bindings section with unique destination channels otherwise it won't
> > work.
> 
> great!
> it seems that the last meeting stimulated you so effectively :)
> 
> 
> could you post a couple of example configurations and usages?

Sure. First example is for the dmix plugin and ice1712 (10 playback 
channels - last two are S/PDIF, so this configuration allows sharing of 
the S/PDIF jack):

pcm.dmix_spdif {
        type dmix
        ipc_key 5678293
        ipc_key_add_uid yes
        slave {
                pcm "hw:0,0"
        }
        bindings {
                0 8
                1 9
        }
}

If you want to share first two analog channels with another applications, 
simply use the same ipc_key configuration:

pcm.dmix_analog {
        type dmix
        ipc_key 5678293
        ipc_key_add_uid yes
        slave {
                pcm "hw:0,0"
        }
        bindings {
                0 0
                1 1
        }
}

Next example is for the dsnoop plugin (also ice1712, S/PDIF capture):

pcm.dsnoop_spdif {
        type dsnoop
        ipc_key 5978293
        ipc_key_add_uid yes
        slave {
                pcm "hw:0,0"
        }
        bindings {
                0 8
                1 9
        }
}

If you ommit the "bindings" section, you'll get all channels. Also, you 
may define more pcm types with same ipc_key configuration with different 
bindings as well.

And finally the dshare plugin (used standard stereo device and using left 
and right channels separately):

pcm.dshare_left {
        type dshare
        ipc_key 6678293
        ipc_key_add_uid yes
        slave {
                pcm "hw:0,0"
        }
        bindings {
                0 0
        }
}

pcm.dshare_right {
        type dshare
        ipc_key 6678293
        ipc_key_add_uid yes
        slave {
                pcm "hw:0,0"
        }
        bindings {
                0 1
        }
}

Final words: I am very happy that we can do these things completely in the
user space but without client/server mechanisms as we promised at the 
beginning of the development.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
