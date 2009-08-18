From: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Subject: Using 8bit mono at 8000Hz with arecord and aplay
Date: Tue, 18 Aug 2009 14:12:13 +0530
Message-ID: <33A0EEB8D50198449794A1AB9DEB1E0186642A95DC@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from colaex01.coreobjects.com (mailus.coreobjects.com [67.89.120.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 803252458F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 10:42:20 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

We tried to record and play the recorded file using arecord and aplay as follows:
arecord -f cd /home/test.wav
aplay -f cd /home/test.wav

The file gets recorded and played correctly.

But if I try to record file of format S8 or U8, I get error:

# arecord -f U8 /home/test_alsa_record_2
Recording WAVE '/home/test_alsa_record_2' : Unsigned 8 bit, Rate 8000 Hz, Mono
arecord: set_params:979: Sample format non available

# arecord -f S8 /home/alsa_record_2
Recording WAVE '/home/alsa_record_2' : Signed 8 bit, Rate 8000 Hz, Mono
arecord: set_params:979: Sample format non available

Is there any other way to set the format as S8 or U8? Or only cd/cdr/dat formats can be played using alsa?

Regards,
--Shilpa.
