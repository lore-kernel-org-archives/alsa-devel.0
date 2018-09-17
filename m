From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bug#908938: alsa-utils: amixer does not unmute
 pulseaudio
Date: Mon, 17 Sep 2018 11:07:37 +0200
Message-ID: <0f157593-9ff7-beb0-5477-a4a8c34ed81a@ladisch.de>
References: <87lg8194nz.fsf%steelman@post.pl>
 <20180917073732.jcdgihgwi7bvtvj3@toy.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id A8CAD26761D
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 11:07:38 +0200 (CEST)
In-Reply-To: <20180917073732.jcdgihgwi7bvtvj3@toy.home.lxtec.de>
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
To: alsa-devel@alsa-project.org, =?UTF-8?Q?=c5=81ukasz_Stelmach?= <steelman@post.pl>, 908938@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

In theory, alsamixer and amixer should be able to access the same controls in the same way.

Please show the output of "amixer scontrols".
What is the output of the "toggle"/"unmute" commands without "-q"?


Regards,
Clemens
