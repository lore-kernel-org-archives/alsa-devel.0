From: Robin Gareus <robin@gareus.org>
Subject: [patch] 18i6 mixer implementation -- was Focusrite
 Scarlett 18i6 mixer
Date: Sun, 20 Jan 2013 20:25:07 +0100
Message-ID: <50FC4493.4030807@gareus.org>
References: <50F8C9FB.3010200@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 847E72616A3
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2013 20:25:13 +0100 (CET)
Received: from [10.8.0.6] (rg42.org [85.214.110.134])
 by smtp.strato.de (jorabe mo50) (RZmta 31.13 AUTH)
 with ESMTPA id z0618ap0KH8Thg for <alsa-devel@alsa-project.org>;
 Sun, 20 Jan 2013 20:25:12 +0100 (CET)
In-Reply-To: <50F8C9FB.3010200@gareus.org>
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

On 01/18/2013 05:05 AM, Robin Gareus wrote:
> Hi,
> 
> I've started to reverse engineer the 18i6 mixer protocol and came up
> with a proof-of-concept test script which includes documentation:
> 
>   https://github.com/x42/scarlettmixer
> 
> Except for a few fixed controls and switches, the 18i6's mixer and
> router is [likely] too complex to be exposed via ALSA's mixer interface.
> AFAICT it'll require a dedicated control application - like hdspmixer -
> in order to make full use of it.

OK. I'll eat my words on that. While a dedicated app will certainly be
more appropriate to access the 18x6 mixter matrix and routing schema.
The whole interface can be exported as standard ALSA mixer:

The patch is rather large, please view it on github:
https://github.com/x42/alsa-driver/commit/3d9c17a3a0a8f4d86489fe9ff8ddff53dde8cdc5

It is based on the latest git.alsa-project.org/alsa-driver.git but
rebases cleanly onto vanilla and rt linux. Tested on debian/wheezy with
linux 3.2.35-2-rt.

Comments and feedback are welcome.

Cheers!
robin
