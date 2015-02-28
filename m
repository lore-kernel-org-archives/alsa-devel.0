From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Issue with snd-aloop and alsaloop in my embedded linux
	custom board
Date: Sat, 28 Feb 2015 15:57:48 +0000
Message-ID: <1425139107380.25188@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0119.outbound.protection.outlook.com [134.170.132.119])
 by alsa0.perex.cz (Postfix) with ESMTP id 703982604A7
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 16:57:53 +0100 (CET)
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Lars,


I hope you were providing solutions for alsa issues, I am running out of the below issue, hope could you please help me in resolving this issue or could you please redirect to the respective links where my queries can be posted & get the solutions for the problem


The below is the virtual cards created after configuring snd-aloop in the linux kernel

snd-aloop provided 2 pass-through devices as shown in the below


card 0, device 0

card 0, device 1


But am unable to perform the loop back ie., what ever am playing am unable to record in the virtual device

As per the logs below, am using the below commands to perform loopback, could you please let me know why am unable to perform the loopback with the below commands or please let me know am I missing any configurations


aplay -D hw:0,0,0 play.wav

arecord -D hw:0,1,0 record.wav


root@am335x-evm:/# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 1: UDA1345TS [TI UDA1345TS], device 0: UDA134x uda134x-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@am335x-evm:/#



Kindly do the needful as early as possible,


Many Thanks in advance
