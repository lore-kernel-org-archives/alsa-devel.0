From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Audigy LS SPDIF output.
Date: Tue, 22 Jun 2004 16:23:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D84EE9.6000405@superbug.demon.co.uk>
References: <40D72EBF.80108@superbug.demon.co.uk> <40D7463C.5090406@ait.nrl.navy.mil> <40D75C54.7010700@superbug.demon.co.uk> <40D7AF33.5030405@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40D7AF33.5030405@superbug.demon.co.uk>
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

I have uploaded new versions of:
audigyls.c
AudigyLS.conf

http://www.superbug.demon.co.uk/alsa

New feature:
1) SPDIF output of PCM stereo sound.

Bugs:
Output of AC3/DTS does not work yet even though setting of non-audio 
bits is currently working. The card must be doing some resampling, or 
mixing of some other inputs.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
