From: Micah Bucy <micah.bucy@gmail.com>
Subject: iMac 9,1 sound
Date: Wed, 1 Apr 2009 20:04:32 -0400
Message-ID: <e40c6ffa0904011704y2d4e1029p854244c132897541@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E2BAD244AA
	for <Alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 02:04:35 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so243708ywr.2
	for <Alsa-devel@alsa-project.org>; Wed, 01 Apr 2009 17:04:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was able to get sound working on the new iMac by adding the following to
alsa-driver-1.0.19/alsa-kernel/pci/hda/patch_realtek.c

case 0x106b4900: /* iMac 9,1 */

underneath line 7013
case 0x106b1000: /* iMac 24 */

(this kept it from using the alc883 since the revision_id is 0x100103).

I did find though, that using the mbp3 option is what allowed sound to
work.  The same issues with the macbook pro aluminum apply here.  the
channel must be switched to 2ch to mute built-in speakers and to 6ch to
unmute.  There is another issue here though.  the playback from the speakers
is barely audible, i'm guessing it's similar to the issue with the right
speaker on the macbook pro.  I'm guessing there needs to be adjustments to
the pins defined.

My current alsa-info resides at
http://www.alsa-project.org/db/?f=5bfaadf03f7134e9ef2c3a934fb4084d36ba2d93

If there's anything else I can do to help this along, let me know.  I do
have the macbook pro aluminum, so I can test there as well.

-Micah
