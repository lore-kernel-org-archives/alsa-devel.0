From: dunk fordyce <mailinglist@dunkfordyce.co.uk>
Subject: seg fault
Date: Tue, 18 Jun 2002 17:59:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020618175932.0bc0ad84.mailinglist@dunkfordyce.co.uk>
Reply-To: him@dunkfordyce.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

anyone tell me why i get a seg fault?
( excuse the c++ but im learning :)

#include <iostream>
#include <alsa/asoundlib.h>
#include <sndfile.h>

using namespace std;

#define CLI_MSG_ERR "Error: "
#define CLI_MSG_INFO "*** "
#define CLI_MSG_CONT " [ cont... ] "
#define CLI_MSG_VAR "---> "
#define CLI_MSG_SEP "-------------------------------------"

char *pcm_name;

snd_pcm_t *pcm_handle;
snd_pcm_stream_t stream=SND_PCM_STREAM_PLAYBACK;
snd_pcm_hw_params_t *hwparams;

int channels= 2;
int rate= 44100;

int buffer_time= 500000;
snd_pcm_sframes_t buffer_size;
int period_time= 100000;
snd_pcm_sframes_t period_size;

int main(int argc, char *argv[])
{
    pcm_name=strdup( "plughw:0,0");
    snd_pcm_hw_params_alloca(&hwparams);
    
    if (snd_pcm_open( &pcm_handle, pcm_name, stream, 0)<0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_open" << endl;
	return -1;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_open ok" << endl;
    }


    // now for the config 
    
    cout << CLI_MSG_INFO << "going for config" << endl;;
    
    int channels= 2;
    int rate= 44100;
    
    // SND_PCM_SFMT_S16_LE / SND_PCM_SFMT_US 
    //pf.channels= 2;
    //pf.rate= 44100;
    
    if (snd_pcm_hw_params_any( pcm_handle, hwparams) <0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_hw_params_any" << endl;
	return -1;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcw_hw_params ok" << endl;
    }

    if (snd_pcm_hw_params_set_access( pcm_handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED) <0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_hw_params_set_access" << endl;
	return -1;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_hw_params ok" << endl;
    }
    
    if (snd_pcm_hw_params_set_format( pcm_handle, hwparams, SND_PCM_FORMAT_S16_LE) <0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_playback format ( format not supported? )" << endl;
	return -1;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_playback_format ok" << endl;
    }

    int dir;
    rate=snd_pcm_hw_params_set_rate_near( pcm_handle, hwparams, rate, &dir);
    
    if (dir!=0)
    {
	cout << CLI_MSG_INFO << "could not use desired rate - now using " << rate << " as rate" << endl;
    }
    
    if (snd_pcm_hw_params_set_channels( pcm_handle, hwparams, 2) <0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_hw_params_set_channels" << endl;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_hw_params_set_channels ok" << endl;
    }

    if ( snd_pcm_hw_params_set_buffer_time_near( pcm_handle, hwparams, buffer_time, &buffer_time) <0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_hw_params_set_buffer_time_near" << CLI_MSG_CONT << endl;
	cout << CLI_MSG_ERR << "could not use desired buffer time - now using " << buffer_time << " as buffer time" << endl;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_hw_params_set_buffer_time ok" << endl;
    }

    buffer_size= snd_pcm_hw_params_get_buffer_size( hwparams);
    cout << CLI_MSG_VAR << "buffer_size= " << buffer_size << endl;
    
    if ( snd_pcm_hw_params_set_period_time_near( pcm_handle, hwparams, period_time, &dir) <0)
    {
	cout << CLI_MSG_ERR << "could not set desired period_time" << endl;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_hw_params_set_period_time_near ok" << endl;
    }
    
    period_size=snd_pcm_hw_params_get_period_size( hwparams, &dir);
    cout << CLI_MSG_VAR << "period_size= " << period_size << endl;
    
    if (snd_pcm_hw_params( pcm_handle, hwparams) <0)
    {
	cout << CLI_MSG_ERR << "failed on snd_pcm_hw_params" << endl;
    }
    else
    {
	cout << CLI_MSG_INFO << "snd_pcm_hw_params ok" << endl;
    }
    
    cout << CLI_MSG_INFO << "attempting to load..." << endl;

    int s= (period_size * channels * snd_pcm_format_width(SND_PCM_FORMAT_S16_LE)) /8 ;

    cout << CLI_MSG_VAR << "s=" << s << endl;
    
    SNDFILE *in_file;
    SF_INFO sf_info;

    int str_buffer[s];

    int readcount;
    
    cout << CLI_MSG_VAR << "sizeof(str_buffer)= " << sizeof(str_buffer) << endl;

    cout << CLI_MSG_INFO << "opening " << argv[1] << endl;
    
    in_file= sf_open_read( argv[1], &sf_info); 

    /*
    sf_get_header_info( in_file, str_buffer, 4096, 0);

    cout << CLI_MSG_INFO << "file info: " << CLI_MSG_CONT << endl;
    cout << CLI_MSG_SEP << endl;
    cout << str_buffer << endl;
    cout << CLI_MSG_SEP << endl;
    */
    
    while( readcount= sf_read_int( in_file, str_buffer, s))
    {
	cout << CLI_MSG_VAR << "readcount= " << readcount << endl;
	cout << CLI_MSG_VAR << "snd_pcm_writei= " << snd_pcm_writei( pcm_handle, str_buffer, readcount) << endl;
    }

    
    
    free(str_buffer);
    
    return 0;
}

----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                      >>>     http://thinkgeek.com/sf    <<<
