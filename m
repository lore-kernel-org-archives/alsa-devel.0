From: malabarkikrok <malabarkikrok@altern.org>
Subject: VIA 8237 and Cmedia CMI9761 surround Problem
Date: Fri, 02 Sep 2005 17:35:55 +0200
Message-ID: <4318715B.9050405@altern.org>
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

Hello,

I have a Via 8237 Sound card chipset and I try to make the 5.1 sound
working.

I have tryed many versions of alsa driver including the 1.0.10rc1 and it
is all the time the same problem :

the sound works fine on the center, LFE and Front speakers but I didn't
manage to make the rear speakers working.

also, in alsamixer I can't change the volume of the surround mixer. I
can just mute/unmute it but with the others speakers the volume works fine.

my amixer output :

amixer | grep -i surround
Simple mixer control 'Surround',0
Simple mixer control 'Surround Jack Mode',0




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
