From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: About the matrix control...
Date: Thu, 10 Apr 2003 21:42:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304102141090.24159-100000@pnote.perex-int.cz>
References: <1050010218.1636.20.camel@Jay>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050010218.1636.20.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: "tiwai@suse.de" <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 10 Apr 2003, Giuliano Pochini wrote:

> 
> >> About the matrix control, what did you decide ?
> > it's accessed via normal control API.
> > you can create "duplicated" entries by specifying the count field for
> > snd_kcontrol_new_t.  for each duplicated entry, only the volatile part
> > is created uniquely, which is accessed via ctl->vd[index].
> 
> I can't think of any use of ->vd... Inside callbacks do I get the
> control number by kcontrol->index ?  Ok, but why ?  It was much simpler
> to make struct sndrv_ctl_elem_value.value.integer.value[] larger or put
> data in .value_ptr-> . What am I missing ?

Please, reread the thread. It's better to lock only one element than
whole row (one dimension) in the matrix. Imagine applications sharing only 
a part of matrix.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
