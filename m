From: Ryan Winter <Ryan.Winter@nautronix.com.au>
Subject: Hammerfall HDSP
Date: Wed, 23 Jun 2004 13:42:49 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087969368.25298.27.camel@winter.nautronix>
Mime-Version: 1.0
Content-Type: text/plain
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
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

We are currently setting the analogue digital interface to run in double
speed, and using the hammerfall sound card in 48kHz mode, and manually
interleaving the 2 channels together into a single 96kHz channel. I have
the sound card autosync reference setup to use the word clock input at
48kHz, which is also syncing the analogue digital interface.

What I am wondering, is that if I change the Sample Clock Source from
Autosync (Slave/48kHhz) to 96Khz (Master/96kHz) which removes me needing
to interleave the channels in software, then will I have any problems
with synchonisation between the sound card and the analogue digital
interface.

Sorry if this explaination is a bit confusing, I guess what I'm really
asking is what does the Sample Clock Source actually do?

Ryan


--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  
Any views or opinions presented are solely those of the author and do not necessarily represent those of NAUTRONIX LTD.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of 
this email is strictly prohibited.  If you have received this email in error please contact the sender.   

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses 
being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such e-mail messages 
and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability 
on our part arising directly or indirectly out of any virus is excluded.  Please ensure that you run virus checking software on all e-mail 
messages and attachments before reading them.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
