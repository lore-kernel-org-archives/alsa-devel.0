From: Nowardev-Team <nowardev@gmail.com>
Subject: ALC861-VD bad recording issue
Date: Sun, 6 Feb 2011 18:52:55 +0100
Message-ID: <AANLkTin+S=NM+nzJYZj3d76_ZvNxA+77fBx8n33-pcdJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BBC171037EA
	for <alsa-devel@alsa-project.org>; Sun,  6 Feb 2011 18:52:59 +0100 (CET)
Received: by eyg24 with SMTP id 24so1817700eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Feb 2011 09:52:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

fixed

my cards eats only 48000  with this

ffmpeg -f  alsa  -ac 2 -ar 48000  -i hw:0,0   -s 1024x768 -f x11grab -r 30
 -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads
0 output.

works note ar 48000

with this

ffmpeg -f  alsa  -ac 2   -i hw:0,0   -s 1024x768 -f x11grab -r 30  -i :0.0
-acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0
output.

nope
