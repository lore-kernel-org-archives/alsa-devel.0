From: Arthur Peters <amp@singingwizard.org>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Sat, 17 May 2003 15:48:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053204498.5412.11.camel@newbie.localnet.local>
References: <Pine.LNX.4.44.0305171438080.21997-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0305171438080.21997-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I tried this, but I didn't get any additional output. I looked at
include/linux/spinlock.h and it appears that the line you are refering
to only affects UP compiles. This explains why I didn't get any output.

Am I doing something wrong? Anything else I could do to help?

-Arthur

On Sat, 2003-05-17 at 07:47, Jaroslav Kysela wrote:

> Paul, could you, please, enable spinlock debug in your SMP kernel?
> 
> include/linux/spinlock.h:
> 
> #define DEBUG_SPINLOCKS 0       /* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
> 
> Use full debug. I am sorry, but I have not a SMP machine around.
> 
> 
> 						Jaroslav

-- 
Arthur Peters <amp@singingwizard.org>



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
