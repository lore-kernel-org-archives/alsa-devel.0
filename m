From: "Bharath Ramachandramurthy" <bramacha@codeaurora.org>
Subject: Unregister and register the sound card
Date: Wed, 25 Jul 2012 22:48:50 -0700
Message-ID: <003201cd6af2$55879070$0096b150$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-devel-bounces@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

 

After the kernel has booted up and sound card detection is also fine, if
there is a requirement

To unregister the sound card and re-register it back to ALSA SOC framework,
what is the recommendation,

Especially when platform, codec & cpu dai drivers are registering with ALSA
framework only at bootime ?

 

Am noticing that when sound card is
unregistered(platform_device_unregister), all dai links gets deregistered 

(pls note the driver is not removed from kernel, only the device is removed
from alsa framework)

but when I try to add the same using platform_device_add(soc-audio), 

observe that dai links registration doesn't go thru fine as the cpu dais are
not re-registered back to ALSA framework.

This is because the probes of the cpu dais weren't called as it was not
never unregistered with the kernel.

 

What is the best way to overcome this pbm ?

 

 

Thanks

Bharath

 

 
