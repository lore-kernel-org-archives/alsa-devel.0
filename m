From: Dan Tihelka <dtihelka@kky.zcu.cz>
Subject: Re: Build-in mixer
Date: Fri, 10 Oct 2003 10:41:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8670C7.5020908@kky.zcu.cz>
References: <3F83C9B8.9050407@kky.zcu.cz>	<200310081124.h98BOGqq018813@oud> <s5hsmm49bq5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmm49bq5.wl@alsa2.suse.de>
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



Takashi Iwai wrote:

>it's becoming an FAQ... :)
>
>pcm.!default {
>	type plug
>	slave.pcm "dmix"
>}
>
>the point is '!' prefix, which means overriding the existing
>definition.
>
>
>Takashi
>

Great, it works. Thank You very much for your help.

But i have one other question. When i tried to play more sounds 
simultenaously (using aplay), the message :  "underrun!!! (at least 
....ms long)" occured. Is it OK?

Dan




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
