From: Mathieu Dube <mdube@8d.com>
Subject: format problem
Date: Fri, 15 Mar 2002 10:09:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02031510095602.00888@mdube.usine.8D.com>
Reply-To: mdube@8d.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
         Im using the alsa API and I call snd_pcm_plugin_params with the 
pp.format.format at SND_PCM_SFMT_U16_LE.
         But when I call snd_pcm_plugin_setup and snd_pcm_get_format_name on 
setup.format.format it outputs:
--> Signed 16-bit Little Endian

         Why is that??

btw, I check for return values and all seems well.

Thanks 

-Mat
-- 
Mathieu Dube -- mdube@8d.com
8D Technologies Inc.
http://www.8d.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
