From: Don Mackie <rebirth@orcon.net.nz>
Subject: Question - selecting soundfonts/banks
Date: Fri, 21 May 2004 16:44:17 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40AD8921.8000503@orcon.net.nz>
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Can someone please explain to me the relationship between midi 
bank_msb/bank_lsb_prognum, and soundfontnum/bank_lsb/prognum on fluidsynth?

I'm successfully sending prog change events, as well as LSB bank select 
events.

However, I'm also trying to select banks within different soundfonts, by 
sending BANK_SELECT_MSB events, but things are not working.

My code presently sends BANK_SELECT_MSB controller event, then 
BANK_SELECT_LSB controller event, then PBMCHANGE event, in that order.

What do i need to do in my code, so I can reliably select different 
sounds from different banks from different loaded soundfonts?

-- 

Kind regards
David

--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
