From: Manu Sharma <manu.sharma@ma.tech.ascom.ch>
Subject: Conversion from S16 format to ALAW
Date: Tue, 16 Nov 2004 08:59:05 +0100
Message-ID: <4199B349.4080404@ma.tech.ascom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I am trying to sample and play alaw streams on my iPAQ 5500. The HW 
driver registers support for S16_LE only. So, to achieve my purpose, I 
register a plugin like following in my alsa.conf file:

pcm.alaw {
	type alaw
	slave {
		pcm  "hw:0.0"
		format S16_LE
	}
}

With this, when I use arecord to capture sound, I get an error "arecord: 
set_params:832: Sample format not available".

Is there something wrong in my configuration setup or am I missing 
something ? Any clues or suggestions would be appreciated.

Regards,
Manu


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
