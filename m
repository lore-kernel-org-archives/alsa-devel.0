From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Mon, 19 Sep 2005 15:36:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509191511290.8552@dhcp73.suse.cz>
References: <432D6C3A.4000001@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432D6C3A.4000001@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 18 Sep 2005, James Courtier-Dutton wrote:

> Hi,
> 
> Here is a first draft of one possible way to implement dB gain display in
> alsamixer.

I would reject it. My comments:

1) breaks backward compatibility
2) I don't like to have this information in the sndrv_ctl_elem_value 
   struct

My idea is to create an optional path between driver and user space to 
give any additional information about controls and perhaps global mixer 
view.

- per control information (new ioctl)

struct sndrv_ctl_elem_addon {
	struct sndrv_ctl_elem_id id;		/* W: element ID */
	unsigned int size;
	void *ptr;
};

I would propose to have this information in a text form parsed in the user 
space (alsa-lib). It will be quite flexible (the old user space binary 
will skip new tokens).

So the addon should return something like (for ADDON_DB):

dB_table -9600,-8000,-6400

(explanation: index to table is the value written to driver, dB in * 100 
form)

or 

dB_min -9600
dB_max -6400
dB_step 1600

or

dB_range -9600,-6400,1600

(explanation: min,max,step)

And some complex addon description (with routing description):

mixer_block
dB_range -9600,0,2000
rt_in "PCM Plaback Volume",0
rt_out "Master Playback Volume",0
rt_cond_out xy
/mixer_block

etc. we need to define the syntax for signal routing description...

- global mixer information

Again, I would propose a text presentation. Actually, I'm not sure what 
fits to this section, we can implement it on demand. Perhaps some complex 
routing stuff etc.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
