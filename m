From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa-lib bloat.
Date: Thu, 14 Dec 2006 10:01:48 +0100
Message-ID: <1166086908.27252.280421715@webmail.messagingengine.com>
References: <45795C6D.9030100@superbug.co.uk> <45805507.6090802@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45805507.6090802@pianodisc.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> [...]
> For me it boils down to this: libasound was designed for and is intended 
> for advanced usage by people that were unsatisfied with the capabilities 
> and performance of the more simple interfaces provided with Linux a few 
> years ago.  It is powerful and exactly what I need for our advanced
> usage.

But one problem is that libasound is the only interface, especially
since OSS was deprecated.  The plugin mechanism and the configuration
parser are used by all applications, even if they wouldn't be necessary
on a particular system.

> James Courtier-Dutton wrote:
> > I was thinking that we could really cut down the API to a very limited 
> > subset of the current api, and place #ifdef in the source code, so that 
> > developers could build alsa-lib for embedded systems using just this 
> > subset of the current api.

Using a subset would make it incompatible with the 'real' API.

The hundreds of snd_xxx_get/set_yyy() functions are just wrappers around
a "xxx->yyy = val" or "return xxx->yyy".  If we assume that only "hw"
devices are used, most API calls boil down to a thin wrapper around an
ioctl() call.  So, in a non-dynamic library, all those functions could
be made inline or a macro.

However, this would require a complete reimplementation of the
'embedded' libasound.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
