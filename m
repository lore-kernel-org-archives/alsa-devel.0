From: Peter L Jones <peter@drealm.org.uk>
Subject: Re: Driver headers used by alsa-lib
Date: Fri, 4 Oct 2002 18:48:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210041848.01838@advent.drealm.org.uk>
References: <Pine.LNX.4.44.0210041255490.23670-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0210041255490.23670-100000@marabou.research.att.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Pavel Roskin <proski@gnu.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 04 Oct 2002 18:20, Pavel Roskin wrote:
> Hello!
>
[snip - forgive me chopping the lot :-)]
>
> I'm ready to provide patches once somebody confirms that my understanding
> of the problem is correct.

I think you're perfectly correct.

It sounds like ALSA is doing _exactly_ like what the kernel developers used to 
complain about the glibc developers doing - compiling against the kernel 
headers.  As you suggest, it's _wrong_!

There needs to be a clear split - kernel space code and user space code.  
Consider them maintained in separate universes.  Only at runtime do they 
_need_ to co-exist.  If the kernel developers change an interface, they need 
to tell the user-space (library) developers what the change is.

The two developer teams could have entirely different requirements for 
organising header files, too...

(Well, it beats "me too" but, having reread the above, I'd like to add that I 
think I've gone a little overboard :-).)

-- Peter



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
