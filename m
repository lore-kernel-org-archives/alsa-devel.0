From: Peter Enderborg <pme@ufh.se>
Subject: 1.0.9rc2
Date: Sun, 01 May 2005 21:15:09 +0200
Message-ID: <42752ABD.9010900@ufh.se>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I upgraded my 2.6.11.8 kernel baced machine with 1.0.9rc2 alsa.
Alsaplayer sometimes uses a lot of CPU even when not playing.
 From top:

Tasks: 143 total,   2 running, 141 sleeping,   0 stopped,   0 zombie
Cpu(s): 11.8% us, 41.5% sy,  0.0% ni, 16.9% id, 27.1% wa,  0.8% hi,  2.1% si
Mem:   2075512k total,  2024640k used,    50872k free,    22344k buffers
Swap:  1309216k total,        0k used,  1309216k free,  1603944k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  
COMMAND          
 6169 pme       15   0 47692 7420 4540 S 80.4  0.4   4:54.59 
alsaplayer       
 2850 root      15   0  140m  80m 9276 R  5.9  4.0  41:39.57 
X                
 3608 pme       15   0  198m 116m  20m S  2.0  5.7  13:27.45 
mozilla-bin      
    1 root      16   0  1460  480  428 S  0.0  0.0   0:00.93 
init             
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 
migration/0      
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 
ksoftirqd/0      
    4 root      10  -5     0    0    0 S  0.0  0.0   0:00.06 
events/0         
    5 root      12  -5     0    0    0 S  0.0  0.0   0:00.01 
khelper          
   10 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 
kthread          
   19 root      20  -5     0    0    0 S  0.0  0.0   0:00.00 
kacpid           
  113 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 
kblockd/0        
  126 root      15   0     0    0    0 S  0.0  0.0   0:00.00 
khubd            
  180 root      15   0     0    0    0 S  0.0  0.0   3:04.11 
pdflush          
  182 root      11  -5     0    0    0 S  0.0  0.0   0:00.00 
aio/0            
  181 root      15   0     0    0    0 S  0.0  0.0   7:49.08 kswapd0     
 

Anyone else see this ?


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
