From: Alamy Liu <alamy_alsa@mail.alamy.idv.tw>
Subject: Arm based driver ?
Date: Wed, 27 Nov 2002 21:38:50 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE4CAEA.6020006@mail.alamy.idv.tw>
References: <Pine.HPX.4.33n.0211270925010.22277-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All,

  I am going to write a audio driver which connect to ARM based CPU 
directly using I2C and L3.
 From the developer's document. It seems the main structure are Card & 
Chipset.
In the Card layer, what kind of card driver should I implement ?
  A virtual-card ?  (exp : i2c/i2c-pxa250.c and l3/l3-pxa250.c 
(i2c/l3/l3-pxa250.c ?) )
Or there is another structure for such a situation ?

  Regards,

Alamy Liu



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
