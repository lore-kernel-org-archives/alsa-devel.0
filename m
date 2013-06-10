From: Robert Billing <bob@tnglwood.demon.co.uk>
Subject: Device enumeration
Date: Mon, 10 Jun 2013 10:05:13 +0100
Message-ID: <51B596C9.6090701@tnglwood.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tnglwood.demon.co.uk (tnglwood.demon.co.uk [83.104.36.146])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E4A2608D4
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 11:05:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by tnglwood.demon.co.uk (8.14.5/8.14.5) with ESMTP id r5A95DK5002228
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 10:05:14 +0100
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

I am currently developing a package to play theatrical sound effects, 
which has two play channels that I want to be able to attach to two 
different ALSA devices. To allow the users, who are theatre directors 
and are *not* technical to do this I am trying to provide a drop-down 
list of play devices. I can get the raw devices by parsing either the 
output from aplay -L, or from /proc/asound. The problem comes with 
devices defined in .asoundrc. I have this in .asoundrc on the 
development system:

pcm.speakers {
     type pulse
     device alsa_output.pci-0000_02_06.0.analog-stereo
}

ctl.speakers {
     type pulse
     device alsa_output.pci-0000_02_06.0.analog-stereo
}

pcm.cans {
     type pulse
     device alsa_output.pci-0000_00_1f.5.analog-stereo
}

ctl.cans {
     type pulse
     device alsa_output.pci-0000_00_1f.5.analog-stereo
}

This works and it is possible to play to the devices "cans" or 
"speakers" to get output on headphones and speakers respectively, but 
these names don't appear in the output from aplay.

What I need is some clean way of getting a list of the aliases. This 
package will have to be capable of being installed on any Linux system 
without needing to edit configuration files manually. However if some 
tool or some part of the installation process has edited a configuration 
file I want the aliases to appear in my list of devices.

What is the right way to do this?

-- 
Robert Billing,

Phone/fax +44 (0) 1344-772849
bob@tnglwood.demon.co.uk

Tanglewood,
64, Pinehill Road,
Crowthorne,
Berks, RG45 7JR
