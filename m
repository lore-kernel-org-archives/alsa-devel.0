From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: matrix mixer control (Re: Complex mixer questio
Date: Mon, 31 Mar 2003 12:56:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030331125623.pochini@shiny.it>
References: <s5hznnbj47h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznnbj47h.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 31-Mar-2003 Takashi Iwai wrote:
> as we talked in the LAD meeting, there are some possibilities:
>
> 1. implement it on hwdep device
> 2. implement it as a new control element (e.g. CTL_ELEM_MATRIX)
> 3. introduce a flag to allow the indirect access with CTL_ELEM_INTEGER
> 4. use 1500+ mixer elements.

I vote for 2. It provides what hi-end card drivers need and IMHO it
should be simple to implement. There is another possibility: two
virtual controls, row and column, select an element of the matrix and
a third control r/w the value. I don't like it. I prefer each element
controls a real hw parameter.

Bye.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
