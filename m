From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Mon, 17 Mar 2008 20:45:29 -0400
Message-ID: <75b66ecd0803171745u52e4e3e3u2a959d1f3676902c@mail.gmail.com>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
	<47DDE2F7.7000904@keyaccess.nl> <s5hmyoxu66g.wl%tiwai@suse.de>
	<cab05a880803171727u6df4897an677d197eec4c28e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <cab05a880803171727u6df4897an677d197eec4c28e6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user <alsa-user@lists.sourceforge.net>, Rene Herman <rene.herman@keyaccess.nl>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 17, 2008 at 8:27 PM, Alexander Indenbaum
<alexander.indenbaum@gmail.com> wrote:
> Still no PCM in /tmp/pcm.out. I get following error messages though:
>  "(snd_determine_driver) could not open control for card 0"
> "(_snd_config_evaluate) function snd_func_concat returned error: No such
> file or directory"
> "(snd_func_concat) error evaluating strings"
>  "(_snd_config_evaluate) function snd_func_concat returned error: No such
> file or directory"
> "(snd_func_refer) error evaluating name"
>  "(_snd_config_evaluate) function snd_func_refer returned error: No such
> file or directory"
>  "(snd_config_expand) Evaluate error: No such file or directory"
> "(snd_pcm_open_noupdate) Unknown PCM default"
>  "(_snd_pcm_plug_open) Unknown field hint"

Please strace aplay and see what files it's trying to open.

Lee

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
