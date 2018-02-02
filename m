From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Adding support for CMEDIA USB2.0 High-Speed True
 HD Audio
Date: Fri, 2 Feb 2018 19:04:14 +0100
Message-ID: <5915bc4b-a968-c9f8-70b8-8e55f395ec74@ladisch.de>
References: <CAOuaOFuAa0jd9ZAENcnaJci1JmCw+dzAwQqT9bhv2t=i=ndWSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id DE20826791F
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 19:05:57 +0100 (CET)
Received: from olorin.ladisch.de (x59cc8b1d.dyn.telefonica.de [89.204.139.29])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id E3965558162D
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 19:05:54 +0100 (CET)
In-Reply-To: <CAOuaOFuAa0jd9ZAENcnaJci1JmCw+dzAwQqT9bhv2t=i=ndWSA@mail.gmail.com>
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

Jean-Philippe Guillemin wrote:
> CMEDIA USB2.0 High-Speed True HD Audio has iec958 output on device 2 and
> iec958 input on device 0.
>
> I'm trying to create a mapping in USB-Audio.conf :
>      "USB2.0 High-Speed True HD Audio" 2
>
> But I never got a match on "USB2.0 High-Speed True HD Audio".

Please show the output of "aplay -l".


Regards,
Clemens
