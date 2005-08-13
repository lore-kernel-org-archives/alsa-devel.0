From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Volume per voices [Feature Request]
Date: Sat, 13 Aug 2005 13:58:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508131355050.8728@tm8103.perex-int.cz>
References: <42E889DD.2070808@netvigator.com>
 <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
 <42FCB8E4.90702@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42FCB8E4.90702@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Aug 2005, Raymond wrote:

> What is the meaning of SNDRV_CTL_ELEM_ACCESS_INACTIVE ?

Inactive means that the driver does not care when the application updates 
value. It means - this value can be written / read but has no effect / 
meaning. For example, PCM stream related volumes must be initialized to 
some reasonable default at the "open" stage. Then they are active until 
"release" is called. After "release" they become "inactive". You can also 
dynamically add and remove these PCM stream volume controls, but marking 
them inactive is more efficient.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
