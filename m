From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Re: Problem with dmix plugin
Date: Fri, 16 May 2003 01:38:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305160138.41607.n8gray@caltech.edu>
References: <E19GaeX-0000jq-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19GaeX-0000jq-00@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> From: Marco Canini <m.canini@libero.it>
>
> I'm experiencing a problem with the dmix plugin:
> I've followed the instructions present on
> http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php3
> and on
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html
>
> After I call aplay -D mymix test.wav I can't hear no sound, and aplay
> hangs undefinitely.

I've seen this too, but only on certain sound files.  Using strace I 
found that it had something to do with a poll call, but I don't 
remember any specifics ATM.
-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
