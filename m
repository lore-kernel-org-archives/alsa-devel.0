From: holborn <holborn@telefonica.net>
Subject: snd_seq_port_info_get_client & snd_seq_client_info_get_name
Date: Thu, 15 Jan 2004 16:39:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401151639.30565.holborn@telefonica.net>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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



Hi!

Tath's a question/request ...

 'snd_seq_port_info_get_client' returns always the same value?  for hardware 
or  software devices even if are not started in the same order? or if the 
number of devices is different?

I don't checkit ... but if it's not the same number, maybe could be a good 
thing add some extra info in 'snd_seq_client_info_get_name', card number?
 
because if you have two same cards, client_info is the same for both, and port 
can be different each time you restart, if Plug&Play USB cards works (I don't 
know ... ), 

Of course, i suggest that, only if the client return value is always 
different.


Thanks


Josep






-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
