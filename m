From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Doubt on implementing .readi and .readn methods
Date: Fri, 12 May 2006 16:27:51 -0300
Message-ID: <4464E1B7.6070601@instant.com.br>
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

I'm a bit confused about what "areas" and "frames" are supposed to mean, 
and in which order the data pointed to by **bufs corresponds to the data 
that's written to disk in the .writen functions. I tried to follow the 
logic in the functions  snd_pcm_areas_from_buf(),  
snd_pcm_areas_from_bufs(), snd_pcm_file_add_frames(), and 
snd_pcm_areas_copy(), and it feels like a labyrinth.

Another thing, are the .readi and .readn functions supposed to block, or 
can they return less bytes (frames?) than requested?

Cheers,
Juan


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
