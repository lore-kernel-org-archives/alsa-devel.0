From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SoundBlaterX G5
Date: Sun, 15 Jan 2017 11:29:29 +0100
Message-ID: <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
References: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E37C266DFB
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 11:30:02 +0100 (CET)
In-Reply-To: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Milan Oravec <moravec@ukf.sk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Milan Oravec wrote:
> http://www.alsa-project.org/db/?f=74ca49f354e9a100ebf7ba9fe9f6eb82c019f3ef
>
> The device is 192K/24 capable under OSX but only when is DSP clock
> source set to direct stereo, this may be the problem in linux.

There is a mixer control named "Speaker Clock Source".  Doesn't it work?


Regards,
Clemens
