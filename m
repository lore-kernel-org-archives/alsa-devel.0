From: Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 0/3] snd-bcd2000: add audio support and control
	interface
Date: Sat, 31 Jan 2015 22:34:22 +0100
Message-ID: <1422740065-20196-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B3E260526
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 22:34:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The current version of the driver only provides a MIDI interface
to read controller status and switch LEDs. These patches add audio
playback and capture support as well as a control interface to
switch between Phono A and Mic input.
