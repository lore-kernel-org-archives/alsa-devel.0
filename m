From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Mon, 17 Mar 2008 17:01:37 +0100
Message-ID: <47DE95E1.6010404@keyaccess.nl>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>	<47DDE2F7.7000904@keyaccess.nl>	<s5hmyoxu66g.wl%tiwai@suse.de>	<47DE6543.9000909@keyaccess.nl>
	<s5heja9pexc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5heja9pexc.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-03-08 16:07, Takashi Iwai wrote:

>>> Recently I added a new option "truncate" to file plugin.  As default,
>>> it's set to true (for compatibility reason), and the plugin overwrite
>>> the existing file if reopened.  When it's set to false, a new file is
>>> created with a different suffix (up to 1000 files) at each time.
> 
> And I added another new feature to the file plugin to write WAV files
> instead of raw files now to HG tree.  You can specify the format "wav"
> instead of "raw" (the default one).
> 
> It's a so dumb implmenetation and has no check for over 2GB files.
> But it might be more useful in many cases than raw outputs.

Yes. I've used the file plugin occasionally if only for some testing and 
appreciate this. Many thanks.

Rene.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
