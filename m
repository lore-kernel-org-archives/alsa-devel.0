From: Brad Midgley <bmidgley@xmission.com>
Subject: bluetooth headset audio
Date: Wed, 29 Sep 2004 21:41:15 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <415B805B.9040900@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I am working with the group doing bluetooth audio. 
(http://sourceforge.net/projects/bluetooth-alsa/)

Right now we have alsa patches to add a bluetooth alsa device to the 
kernel. It works in conjunction with a userspace bluetooth daemon. It's 
not ideal. For one thing, we should be able to support multiple 
bluetooth headsets at once but that would require more kernel changes.

Is there any way to have an alsa sound driver that lives mostly in 
userspace? If there was something like that, we could load up one driver 
for each headset we wanted to support. We have to route things through 
userspace anyway to use the bluetooth device. It might also be easier to 
get patches accepted. :)

Brad


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
