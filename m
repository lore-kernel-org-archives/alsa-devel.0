From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: I think I found an error in pcm/pcm_file.c
Date: Thu, 11 May 2006 19:50:07 -0300
Message-ID: <4463BF9F.8030307@instant.com.br>
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

Shouldn't this function use snd_pcm_readn() instead of snd_pcm_writen()?

static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, 
snd_pcm_uframes_t size)
{
        snd_pcm_file_t *file = pcm->private_data;
        snd_pcm_channel_area_t areas[pcm->channels];
        snd_pcm_sframes_t n = snd_pcm_writen(file->gen.slave, bufs, size);
        if (n > 0) {
                snd_pcm_areas_from_bufs(pcm, areas, bufs);
                snd_pcm_file_add_frames(pcm, areas, 0, n);
        }
        return n;
}



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
