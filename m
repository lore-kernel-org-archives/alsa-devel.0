From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: snd_kcontrol_new_t
Date: Fri, 16 May 2003 11:29:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Gh4L-0004yF-00@sc8-sf-list1.sourceforge.net>
References: <20030515195544.22379.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 15 May 2003 19:55:44 PDT."
             <20030515195544.22379.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>(The web page has a diagram on it, you won't have to download any document)
>In the diagram, every input to every mixer has a separate attenuation control
>"Volume" which is not explicitly shown for space reasons.

eliot - i think you should probably track the approach in the hdsp
driver. although its not necessarily the correct one long term, it has
the same mixer design (a matrix, in essence) and whatever solution
is used for the hdsp will be the best one at any given point in time
for your card too. that solution may change over time, of course.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
