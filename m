From: Carlos Munoz <carlos@kenati.com>
Subject: buffer_bytes not multiple of period_bytes
Date: Wed, 19 Apr 2006 18:54:38 -0700
Message-ID: <4446E9DE.4080709@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi all,

I just noticed that alsa doesn't allocate a buffer size that is a 
multiple of the period size. For example when aplay plays a 8000 sample 
rate wav file, the driver gets the following:

    buf_bytes=8000
    period_bytes=1024

How am I going to dma the last period ?

I verified that the 16000 sample rate also has the same problem. 
However, when the sample rate is 44100 the buffer size is a perfect 
multiple of the period size.

Thanks,


Carlos Munoz


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
