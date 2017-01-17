From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SoundBlaterX G5
Date: Tue, 17 Jan 2017 10:39:48 +0100
Message-ID: <d961d16c-aa8e-18b7-226f-ede89945f5cc@ladisch.de>
References: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
 <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
 <8893efe5-8e73-3f75-b19c-b47891383342@ukf.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5566A2668F1
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 10:39:49 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 140235582666
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 10:39:49 +0100 (CET)
In-Reply-To: <8893efe5-8e73-3f75-b19c-b47891383342@ukf.sk>
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

Milan Oravec wrote:
> I think when I change "Speaker Clock Source" to direct audio sound card capabilities need to be re-enumerated to update sampling rates.
>
> Is there any way to achieve this?

Try unloading and re-loading the driver module (snd-usb-audio).


Regards,
Clemens
