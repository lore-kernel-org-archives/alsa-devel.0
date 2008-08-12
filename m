From: Rahul Iyer <rahul.iyer@ymail.com>
Subject: Ideal fragment size and number range
Date: Tue, 12 Aug 2008 10:58:51 -0700 (PDT)
Message-ID: <815261.76183.qm@web59603.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n3b.bullet.mail.ac4.yahoo.com (n3b.bullet.mail.ac4.yahoo.com
	[76.13.13.73]) by alsa0.perex.cz (Postfix) with SMTP id 8F89D2445D
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 19:58:53 +0200 (CEST)
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

Hi All

For a reasonably responsive application, what would be the ideal fragment size and maximum fragment number range when set using SNDCTL_DSP_SETFRAGMENT (0xMMMMSSSS)? I understand the answer would correspond to the audio buffer size, but I am not certain about the formula involved here.

Also for an hda-intel sound card what's the size of ring buffer (for both recording and playback)?

Thanks
../rahul
