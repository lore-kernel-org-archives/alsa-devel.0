From: Paul Davis <pbd@op.net>
Subject: Re: What is the current status of the alsa sound server (signal polling)?
Date: Fri, 19 Apr 2002 13:00:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9pje1$p1g$2@main.gmane.org>
References: <000101c1e766$39a37a60$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 19 Apr 2002 01:51:18 EDT."
             <000101c1e766$39a37a60$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Also, what is the current status of gstreamer in this department and
>jack? (I tried artsd and that one simply doesn't cut it)

jack allows any number of applications to use a single audio
interface, up to a run-time configurable limit imposed by the total
maximum number of "ports" in the JACK system. the default is 128
ports, but any number is theoretically OK.

--p
