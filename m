From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: moving driver into alsa-kernel/
Date: Wed, 20 Aug 2003 11:05:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308201103380.3450-100000@pnote.perex-int.cz>
References: <1061321274.1929.13.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1061321274.1929.13.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "mjander@mat.utfsm.cl" <mjander@mat.utfsm.cl>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Aug 2003, Manuel Jander wrote:

> Hello,
> 
> Who decides when a driver can be moved into alsa-kernel/ ? Is there any
> formal process envolved or is it just a matter of "... yeah, this driver
> doesnt crash, let it in..." ? Who is the 'boss' about this matter ?

I and Takashi. Our policy is to keep a new driver in the alsa-driver tree 
for several months and then move it to alsa-kernel (thus to 2.6 kernel 
tree).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
