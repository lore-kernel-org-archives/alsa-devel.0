From: Paul Davis <pbd@op.net>
Subject: Re: prepare(substream)
Date: Wed, 19 Jun 2002 22:35:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17Krmk-0001yU-00@usw-sf-list1.sourceforge.net>
References: <20020619184915.27895.qmail@web11508.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 19 Jun 2002 11:49:14 PDT."
             <20020619184915.27895.qmail@web11508.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I believe that I have misunderstood the meaning of this function, could anyone
>explain?

prepare is used to get the hardware ready to be started. 

>In a test of a driver, I see this sequence for playback:

>pointer()   << gets current h/w pointer location
>copy()      << moves silence or initial data into h/w buffer
>prepare()   << get h/w ready for starting
>copy()      << copy more data
>pointer()   << get current h/w pointer location
>copy()      << etc. etc.
>pointer()
>pointer()


-------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                   >>>     http://thinkgeek.com/sf    <<<
