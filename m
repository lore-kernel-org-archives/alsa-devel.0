From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Mon, 31 Mar 2003 21:59:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303312133440.1283-100000@pnote.perex-int.cz>
References: <E1902vd-0001au-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1902vd-0001au-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Mar 2003, Paul Davis wrote:

> i don't understand this discussion. it seems to originate from
> jaroslav's desire to have alsactl be capable of automatically working
> correctly for everything. i say this because the current scheme with
> the hdsp works just fine, and will work even better in thomas's new
> version of the driver in which all the controls are in the hwdep
> "namespace", so that regular mixer programs won't (or shouldn't) see
> them. all that doesn't work is alsactl.
> 
> amixer is quite able to handle the current hdsp control design, and so
> i ask again, why do we have both amixer and alsactl when they do
> identical work but in different ways? amixer is more flexible, and i
> think that it would be better to focus on extending it (for example,
> by allowing it to handle multiple controls in one invocation) so that
> it can replace alsactl and form the basis of a flexible, powerful
> script-based configuration system. i think this is better than
> requiring the "shoe-horning" of a difficult issue (matrix controls)
> into unnatural frameworks. i say unnatural because the mixer on the
> hdsp series really is a matrix, not 1564 individual controls.

amixer - command line oriented tool to handle card settings oriented only
         to mixer elements
alsactl - handle all elements and store/restore settings to/from a file at 
          one shot

I think that both tools are different. While amixer supports more human 
"readable" format to modify/read elements, the alsactl purpose is batch 
processing of card settings with exact file syntax.

Paul, with all respects, please, read my original message. I am (maybe) 
thinking a bit forward.

Actually, we are not able to ENUMERATE all hardware controls in a generic
way for HDSP regarless you are using the element values as identification
what to read/write or hwdep interface. You need to write your own tools
for this extension to API which is not "standard". No ALSA generic 
applications can share your control mechanism.

Little practise example: Imagine a small program using actual ALSA 
API which watches one control element and shows the actual value and 
writes down the changes. It can be used with EVERY CARD except HDSP with 
it's own API for the matrix mixer. Is this good or bad? It's bad. I was 
happy to see in Karslruhe the sequencer applications working together via 
one interface. The same applies to the control API. If you are different, 
applications don't talk with you anymore.

Also, if you will support all features as the control interface offers, 
then you'll end with nearly same code. And we definitely want to eliminate 
the code duplication.

Please, also think in direction, that we want to control the card settings 
over the control API but not to describe the connection layout (e.g. - 
there is a matrix of volumes with N x M size). This is definitely thing 
for the user space and we'll extend alsa-lib at some time to offer this 
layer to applications as well doing transparent mapping to the control 
elements.

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
