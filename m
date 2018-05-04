From: Jay Foster <jay@systech.com>
Subject: Aplay Fails When Reading From stdin
Date: Fri, 4 May 2018 10:51:05 -0700
Message-ID: <8c51a51a-cfa0-e1a7-0682-8f3c13ddc2a7@systech.com>
Reply-To: jay@systech.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcloudmail.hostconnection.net (rcloudmail.hostconnection.net
 [38.96.19.98]) by alsa0.perex.cz (Postfix) with ESMTP id A00C6266C1C
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 19:51:15 +0200 (CEST)
Content-Language: en-US
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

I recently updated may alsa from 1.1.4.1 to 1.1.6.  I now noticed that 
aplay does not work properly (the same as 1.1.4.1) when reading the 
sound file data from stdin.  This might have something to do with the 
recent change with reading the sound file header.

With the previous version of aplay, aplay would report:

Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 22050 Hz, Mono

With 1.1.6, aplay reports:

Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono

This results in static/noise output.  If I explicitly add the '-f S16_LE 
-r 22050' options to aplay, then it does play correctly.

Is this a known bug and is there a fix?

Jay
