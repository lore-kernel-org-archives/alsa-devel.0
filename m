From: Paul Davis <pbd@op.net>
Subject: Re: Selectable async notification signal?
Date: Thu, 11 Apr 2002 12:41:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16vhcq-0006PX-00@usw-sf-list1.sourceforge.net>
References: <s5hzo0ajjbi.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 11 Apr 2002 18:23:13 +0200."
             <s5hzo0ajjbi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stuffed Crust <pizza@shaftnet.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> How painful would it be to add an API call to set the async notification
>> signal to be something other than SIGIO?

[ explanation ]

and just remember not to actually do anything complicated from your
signal handler. ioctl(2), which is used for most ALSA user/kernel
space communication, is not async-safe, and thus cannot be used from a
signal handler without creating undefined behaviour. to quote from at
least one text:

      "In general, applications should do only the minimum possible
       in the handlers for asynchronous signals, such as setting a flag
       or posting a semaphore."

--p
