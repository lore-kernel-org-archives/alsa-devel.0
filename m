From: Paul Davis <pbd@op.net>
Subject: Re: glue for new driver
Date: Sat, 27 Apr 2002 13:01:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E171VZ1-0006u0-00@usw-sf-list1.sourceforge.net>
References: <20020427032659.98182.qmail@web11504.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 26 Apr 2002 20:26:59 PDT."
             <20020427032659.98182.qmail@web11504.mail.yahoo.com>
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

>Hi,
>
>I am writing a driver for a new card, and wonder how the ALSA server will
>recognize my module as one of its own? Besides, is there anything I should kno
>w
>regarding debugging ALSA drivers?

there is no "ALSA server", at least not in the context you're
discussing. 

you should download ALSA from CVS and build your driver within your copy
of the ALSA source tree, modifying makefiles etc. as needed to include
it in the build. that way, when its ready, you can submit a patch back
to jaroslav that includes everything thats needed, not just driver
source. 

--p
