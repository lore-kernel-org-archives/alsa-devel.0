From: "John S. Denker" <jsd@monmouth.com>
Subject: usbaudio won't do 24-bit or 32-bit i/o, and won't do 96000 frames
 per second
Date: Thu, 05 Dec 2002 06:31:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF3911.4060206@monmouth.com>
References: <3DEF2ED7.7000808@monmouth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DEF2ED7.7000808@monmouth.com>
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

     ==== This is a slightly-updated clone of item
     #636946 on the sourceforge bug/patch reporting
     system.  I'm moving it to here (the alsa-devel
     mailing list) at the request of Jaroslav. ====

I bought an Extigy, which is capable of 24-bit i/o. It is
also capable of digitizing 96000 frames per second.

The problem is, the alsa usbaudio driver seems to know
nothing of such capabilities.

I tried modifying the driver source, in analogy to the dummy
driver, but to no avail.

This means I am unable to use ALSA for this application.

Request #1: USB driver supporting 24-bit i/o. I don't care
whether it is encoded as S24_LE or S32_LE, just so long as
all the bits are encoded somehow.

Request #2: USB driver supporting 96000 frames per second.

Suggestion: If the code had better comments and
documentation, it would be easier for folks like me to
contribute fixes to problems such as this.

Note: there are other problems with this driver; see next
bug report.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
