From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Tue, 1 Apr 2003 16:08:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304011557190.1350-100000@pnote.perex-int.cz>
References: <3E893713.20806@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E893713.20806@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 1 Apr 2003, Abramo Bagnara wrote:

> 
> I agree with Jaroslav fully:
> - have one ALSA control for each primitive hw control (1536 different 
> controls)
> - add a field to struct sndrv_ctl_elem_info explaining how index field 
> of sndvr_ctl_elem_id should be interpreted (32,16+16,10+11+11, ecc.)
> 
> This permit to have native support for N dimensional control.
> 
> About kernel memory issues, this concerns easily solvable implementation 
> detail to not worry about when designing sane API.

Ok, I've added the dimension description to the info structure. Although 
it is completely irrelevant to data transfers.

Also, I've implemented multi element in the kernel space to save memory 
and it makes the searching faster. The reference code is in the trident 
driver. I'll recode other drivers containing many "same" controls to use 
this method later.

The user space applications won't notice any changes.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
