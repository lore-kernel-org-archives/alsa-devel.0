From: Bob Ham <node@users.sourceforge.net>
Subject: CAPs
Date: 03 Mar 2002 04:13:45 +0000
Message-ID: <1015128826.993.31.camel@insanity>
References: <200203030118.UAA08398@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200203030118.UAA08398@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2002-03-02 at 20:18, Paul Davis wrote:
> >ok, don't forget to put CAPs on the 2.5 wishlist :-)
> 
> they are already implemented and maintained. its just that (almost)
> nobody turns them on. 

How do you do this now?  This http://www.tml.hut.fi/~tilmonen/givertcap/
page tells me to do change the lines

#define CAP_INIT_EFF_SET    ( ~0 )
#define CAP_INIT_INH_SET    ( ~0 )

in linux/capability.h.  The version I have (2.4.17 plus Andrew Morton's
low latency patch and the rtc patch from alsa's sources) has this:

#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
#define CAP_INIT_INH_SET    to_cap_t(0)

Bob


-- 
Bob Ham: bob@ham.org

My music: http://mp3.com/obelisk_uk
GNU Hurd: http://hurd.gnu.org/

A pessimist expects the weather to get worse.
An optimist hopes it will improve.
A realist adjusts the sails.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
