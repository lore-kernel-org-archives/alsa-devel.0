From: Nathan Morell <frizop@charter.net>
Subject: Trying to make gkrellm work with ALSA.
Date: Wed, 04 Feb 2004 18:29:46 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40218E7A.5050402@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi guys, this is my first note to the list so I'm going to try and get 
some background information to start on this task.

After talking with Bill, the author of gkrellm, I need to find out if 
ALSA supports 'callbacks' (a new concept in c++ to me).

quoted from our email:
----------
A while back I looked at ALSA 0.9 support for gkrellmss but there was no
callback mechanism as there was in ALSA 0.5. Maybe this has changed and
I'll look again (let me know if you have any info on this), but short of
that, it takes a sound server that provides such callbacks. Currently
that's ESD, but I'll probably be adding Jack support fairly soon.
----------


other then the above, and taking a close look at the original source to 
the gkrellm-sound plugin, could anybody offer some advice on my project?

thanks in advance,
--Nathan


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
